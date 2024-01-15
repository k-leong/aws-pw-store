import boto3
import json
import base64

dynamodb = boto3.resource('dynamodb')
kms = boto3.client('kms')
store = dynamodb.Table('store')
salt = dynamodb.Table('salt')

def lambda_handler(event, context):
    account = event['account']
    response = store.get_item(Key={'account': account})
    salt_response = salt.get_item(Key={'account': account})
    # need to base64 decode after retrieving from ddb
    if 'Item' in response:
        # Decrypt the password using KMS
        encrypted_password = response['Item']['password']

        decrypted_password = kms.decrypt(
            CiphertextBlob=base64.b64decode(encrypted_password)
        )['Plaintext'].decode('utf-8')
        print(type(salt_response))
        print(decrypted_password)
        print(decrypted_password.strip(salt_response)) 
    else:
        return None
    
