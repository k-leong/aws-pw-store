import boto3
import json
import secrets
import base64
import os

dynamodb = boto3.resource('dynamodb')
kms = boto3.client('kms')
store = dynamodb.Table('store')
salt = dynamodb.Table('salt')

def lambda_handler(event, context):
    account = event['account']
    password = event['password']

    pw_salt = secrets.token_hex(16)
    salted = password + pw_salt
    encrypted_password = kms.encrypt(
        KeyId=os.environ['KeyId'],
        Plaintext=salted.encode('utf-8')
    )['CiphertextBlob']
    encrypted_salt = kms.encrypt(
        KeyId=os.environ['KeyId'],
        Plaintext=pw_salt.encode('utf-8')
    )['CiphertextBlob']
    
    print(encrypted_password)
    encoded_encrypted_password = base64.b64encode(encrypted_password).decode('utf-8')
    encoded_encrypted_salt = base64.b64encode(encrypted_salt).decode('utf-8')

    store.put_item(
        Item={
            'account': account,
            'password': encoded_encrypted_password
        }
    )
    
    salt.put_item(
        Item={
            'account': account,
            'salt': encoded_encrypted_salt
        }
    )
    return {
        'statusCode': 200,
        'body': json.dumps('Password successfully stored')
    }