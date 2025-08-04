const String amplifyconfig = '''{
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "UserAgent": "aws-amplify-cli/0.1.0",
        "Version": "1.0",
        "IdentityManager": {
          "Default": {}
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "us-east-1_vJMo20Oa9",
            "AppClientId": "6k9drc18bhet9kb1ps1uvvuqnq",
            "Region": "us-east-1"
          }
        },
        "Auth": {
          "Default": {
            "OAuth": {
              "WebDomain": "us-east-1vjmo20oa9.auth.us-east-1.amazoncognito.com",
              "AppClientId": "6k9drc18bhet9kb1ps1uvvuqnq",
              "SignInRedirectURI": "myapp://callback/",
              "SignOutRedirectURI": "myapp://signout/",
              "Scopes": [
                "email",
                "openid",
                "phone"
              ],
              "responseType": "code"
            }
          }
        }
      }
    }
  }
}''';
