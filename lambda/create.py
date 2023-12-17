import boto3
import json
import os

dynamodb = boto3.resource('dynamodb')
kms = boto3.client('kms')
store = dynamodb.Table('store')
salt = dynamodb.Table('salt')

def lambda_handler(event, context):
    # password = event['password']
    # account = event['account']
    # salt = os.urandom(16)
    # salted_password = password + salt
    # # encrypt salted_password using kms
    # encrypted_password = kms.encrypt(
    #     KeyId='alias/password_key',
    #     Plaintext=salted_password,
    #     EncryptionContext={
    #         'account': account
    #     }
    # )

    # store.put_item(
    #     Item={
    #         'password_id': str(hash(password + account)),
    #         'password': salted_password,
    #         'account': account
    #     }
    # )
    # salt.put_item(
    #     Item={
    #         'salt_id': str(hash(salt)),
    #         'salt': salt
    #     }
    # )
    return {
        'statusCode': 200,
        'body': json.dumps('Password successfully stored')
    }