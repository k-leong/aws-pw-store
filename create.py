import boto3
import json
import secrets
import base64

dynamodb = boto3.resource('dynamodb')
kms = boto3.client('kms')
store = dynamodb.Table('store')
salt = dynamodb.Table('salt')

def lambda_handler(event, context):
    account = event['account']
    password = event['password']
    # need to base64 encode before storing into ddb
    pw_salt = secrets.token_hex(16)
    salted = password + pw_salt
    encrypted_password = kms.encrypt(
        KeyId='arn:aws:kms:us-west-1:xxx:key/xxx',
        Plaintext=salted.encode('utf-8')
    )['CiphertextBlob']
    
    print(encrypted_password)
    encoded_encrypted_password = base64.b64encode(encrypted_password).decode('utf-8')
    
    store.put_item(
        Item={
            'account': account,
            'password': encoded_encrypted_password
        }
    )
    
    salt.put_item(
        Item={
            'account': account,
            'salt': pw_salt
        })
    return {
        'statusCode': 200,
        'body': json.dumps('Password successfully stored')
    }