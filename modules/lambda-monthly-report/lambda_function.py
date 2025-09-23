import boto3
import time
from datetime import datetime

# AWS clients
athena = boto3.client("athena")
sns = boto3.client("sns")
s3 = boto3.client("s3")

# ====== CONFIGURATION ======
ATHENA_DB = "cur-database"
ATHENA_TABLE = "aws_cost_optimization_report_testing"
SNS_TOPIC_ARN = "arn:aws:sns:us-east-1:475003458327:cost-report-alerts"
OUTPUT_LOCATION = "s3://cost-usage-work-out/results/"
ARCHIVE_BUCKET = "cost-usage-work-out"
REGION = "us-east-1"
# ===========================

def lambda_handler(event, context):
    today = datetime.today()
    year = today.strftime("%Y")
    month = today.strftime("%m")
    month_name = today.strftime("%B")

    # Athena query
    query = f"""
    SELECT
        line_item_usage_account_id AS account_id,
        ROUND(SUM(line_item_unblended_cost), 2) AS total_cost_usd
    FROM "{ATHENA_DB}"."{ATHENA_TABLE}"
    WHERE year = '{year}' AND month = '{month}'
    GROUP BY line_item_usage_account_id
    ORDER BY total_cost_usd DESC
    """

    print(f"Running Athena query for {month}/{year}...")

    response = athena.start_query_execution(
        QueryString=query,
        QueryExecutionContext={"Database": ATHENA_DB},
        ResultConfiguration={"OutputLocation": OUTPUT_LOCATION}
    )

    query_execution_id = response["QueryExecutionId"]

    # Wait for query to complete
    while True:
        status = athena.get_query_execution(QueryExecutionId=query_execution_id)
        state = status["QueryExecution"]["Status"]["State"]

        if state in ["SUCCEEDED", "FAILED", "CANCELLED"]:
            break
        time.sleep(2)

    if state != "SUCCEEDED":
        reason = status["QueryExecution"]["Status"].get("StateChangeReason", "No reason returned")
        raise Exception(f"Athena query failed: {state} - {reason}")

    results = athena.get_query_results(QueryExecutionId=query_execution_id)
    rows = results["ResultSet"]["Rows"][1:]  # skip header

    if not rows:
        message = f"No CUR data found for {month_name} {year}."
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=message,
            Subject=f"AWS Monthly Cost Report - {month_name} {year}"
        )
        return

    for row in rows:
        account_id = row["Data"][0].get("VarCharValue", "N/A")
        cost = row["Data"][1].get("VarCharValue", "0.00")

        message = f"""📊 AWS Monthly Cost Report — {month_name} {year}

Billing Period: 01-{month}-{year} to 30-{month}-{year}  
Report Generated: {today.strftime('%d-%b-%Y')}

────────────────────────────────────────────
Account ID: {account_id}  
Total Unblended Cost: ${cost} USD
────────────────────────────────────────────

For detailed service-level breakdowns, please refer to your Athena dashboard or CUR archive in S3.

Thank you for using AWS.
"""

        # Send via SNS with filterable account_id
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=message,
            Subject=f"AWS Monthly Cost Report - {month_name} {year}",
            MessageAttributes={
                "account_id": {
                    "DataType": "String",
                    "StringValue": account_id
                }
            }
        )

        # Save to S3 archive
        key = f"reports/{account_id}/monthly-cost-report-{year}-{month}.txt"
        s3.put_object(
            Bucket=ARCHIVE_BUCKET,
            Key=key,
            Body=message.encode("utf-8")
        )

    print("All reports sent and archived successfully.")