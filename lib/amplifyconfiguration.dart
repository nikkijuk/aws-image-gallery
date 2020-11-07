const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-central-1:8f340b71-9805-478a-834e-294b80bfa76f",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-central-1_NC0jZyUK1",
                        "AppClientId": "ktmso0b0rravoj293k3fms29s",
                        "AppClientSecret": "1cq8ga9f5mk9rp0lak018pv4ruknvi1b9sghgli0jplrn7pv76ki",
                        "Region": "eu-central-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "s3galleryimagesbucket121734-dev",
                        "Region": "eu-central-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "s3galleryimagesbucket121734-dev",
                "region": "eu-central-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';