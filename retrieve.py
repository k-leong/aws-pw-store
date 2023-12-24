import boto3
import json
import os

dynamodb = boto3.resource('dynamodb')
kms = boto3.client('kms')
store = dynamodb.Table('store')
salt = dynamodb.Table('salt')

def lambda_handler(event, context):
    # account = event['account']

    return {
        "name": "John",
        "age": 30,
        "city": "New York"
    }