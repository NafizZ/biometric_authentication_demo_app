// // Your amplifyconfiguration.json content goes here.
// // You would typically get this by running 'amplify configure'
// const String amplifyconfig = '''{
//   "UserAgent": "aws-amplify-cli/2.0",
//   "Version": "1.0",
//   "auth": {
//     "plugins": {
//       "awsCognitoAuthPlugin": {
//         "authenticationFlowType": "CUSTOM_AUTH",
//         "userPoolId": "us-east-1vjmo20oa9",
//         "userPoolWebClientId": "6k9drc18bhet9kb1ps1uvvuqnq",
//         "region": "us-east-1",
//         "HostedUI": {
//           "OAuth": {
//             "scopes": [
//               "phone",
//               "email",
//               "openid"
//             ],
//             "domain": "https://us-east-1vjmo20oa9.auth.us-east-1.amazoncognito.com",
//             "redirectSignIn": "myapp://callback/",
//             "redirectSignOut": "myapp://signout/",
//             "responseType": "code"
//           }
//         }
//       }
//     }
//   }
// }''';

const String amplifyconfig = '''{
  "UserAgent": "aws-amplify-cli/0.1.0",
  "Version": "1.0",
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
            "PoolId": "us-east-16yl3AyBfV",
            "AppClientId": "6qg096ufhc6cd1f3v309ekamo2",
            "Region": "us-east-1"
          }
        },
        "Auth": {
          "Default": {
            "OAuth": {
              "WebDomain": "us-east-16yl3AyBfV.auth.us-east-1.amazoncognito.com",
              "AppClientId": "6qg096ufhc6cd1f3v309ekamo2",
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

// const amplifyconfig = '''{
//   "UserAgent": "aws-amplify-cli/2.0",
//   "Version": "1.0",
//   "auth": {
//     "plugins": {
//       "awsCognitoAuthPlugin": {
//         "UserAgent": "aws-amplify-cli/0.1.0",
//         "Version": "0.1.0",
//         "IdentityManager": {
//           "Default": {}
//         },
//         "AppSync": {
//           "Default": {
//             "ApiUrl": "",
//             "Region": "us-east-1",
//             "AuthMode": "AMAZON_COGNITO_USER_POOLS",
//             "ApiKey": ""
//           },
//           "customAuth": {
//             "ApiUrl": "",
//             "Region": "us-east-1",
//             "AuthMode": "API_KEY",
//             "ApiKey": ""
//           }
//         },
//         "CognitoUserPool": {
//           "Default": {
//             "PoolId": "us-east-1_xxxxxxxxx",
//             "AppClientId": "xxxxxxxxxxxxxx",
//             "AppClientSecret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
//             "Region": "us-east-1"
//           }
//         },
//         "CredentialsProvider": {
//           "CognitoIdentity": {
//             "Default": {
//               "PoolId": "us-east-1:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
//               "Region": "us-east-1"
//             }
//           }
//         }
//       }
//     }
//   }
// }''';
