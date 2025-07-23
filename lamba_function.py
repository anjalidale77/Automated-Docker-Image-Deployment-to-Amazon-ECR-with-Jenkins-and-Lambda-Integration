import json
import boto3
from datetime import datetime

def lambda_handler(event, context):
    sns = boto3.client('sns')
    message = {
        'status': 'Docker image pushed',
        'timestamp': str(datetime.utcnow())
    }
    sns.publish(
        TopicArn='arn:aws:sns:us-east-1:123456789012:NotifyMe',
        Message=json.dumps(message),
        Subject='ECR Push Notification'
    )
    return {'statusCode': 200, 'body': 'Notification sent'}
