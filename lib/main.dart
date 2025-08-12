import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart'; // this is the file you showed

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _otpController = TextEditingController();
  String _authState = 'Signed Out';
  String _accessToken = '';
  final _amplify = Amplify;
  final _amplifyAuth = Amplify.Auth;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await _amplify.addPlugin(auth);
      await _amplify.configure(amplifyconfig);
      safePrint('Successfully configured Amplify');
      await _checkAuthState();
    } on AmplifyException catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  Future<void> _checkAuthState() async {
    try {
      final session = await _amplifyAuth.fetchAuthSession();
      if (session.isSignedIn) {
        final cognitoSession = session as CognitoAuthSession;
        final accessToken =
            cognitoSession.userPoolTokensResult.value.accessToken.raw;
        setState(() {
          _authState = 'Signed In';
          _accessToken = accessToken;
        });
      } else {
        setState(() {
          _authState = 'Signed Out';
          _accessToken = '';
        });
      }
    } on AuthException catch (e) {
      safePrint('Failed to check auth session: $e');
      setState(() {
        _authState = 'Signed Out';
        _accessToken = '';
      });
    }
  }

  Future<void> _signInWithHostedUI() async {
    try {
      final result = await _amplifyAuth.signInWithWebUI();
      log(
        "button tapped!! ${result.isSignedIn}  ${result.nextStep}",
      );
      if (result.isSignedIn) {
        final cognitoSession =
            await _amplifyAuth.fetchAuthSession() as CognitoAuthSession;
        final accessToken =
            cognitoSession.userPoolTokensResult.value.accessToken.raw;
        setState(() {
          _authState = 'Signed In';
          _accessToken = accessToken;
        });
        safePrint('Sign in successful');
      } else if (result.nextStep.signInStep ==
          'CONTINUE_SIGN_IN_WITH_CUSTOM_AUTH_CHALLENGE') {
        // This is the key step. After the initial hosted UI login, we are
        // challenged with our custom auth flow (the OTP).
        setState(() {
          _authState = 'OTP Required';
        });
        safePrint('OTP challenge required');
      }
    } on AuthException catch (e) {
      safePrint('Error signing in: $e');
      setState(() {
        _authState = 'Sign In Failed';
      });
    }
  }

  Future<void> _confirmOtp() async {
    try {
      final otp = _otpController.text.trim();
      if (otp.isEmpty) return;

      final result = await _amplifyAuth.confirmSignIn(confirmationValue: otp);

      if (result.isSignedIn) {
        final cognitoSession =
            await _amplifyAuth.fetchAuthSession() as CognitoAuthSession;
        final accessToken =
            cognitoSession.userPoolTokensResult.value.accessToken.raw;
        setState(() {
          _authState = 'Signed In';
          _accessToken = accessToken;
        });
        safePrint('OTP confirmed and sign-in successful');
      } else {
        safePrint(
          'OTP confirmation failed, next step: ${result.nextStep.signInStep}',
        );
        setState(() {
          _authState = 'OTP Failed';
        });
      }
    } on AuthException catch (e) {
      safePrint('Error confirming OTP: $e');
      setState(() {
        _authState = 'OTP Failed';
      });
    }
  }

  Future<void> _signOut() async {
    try {
      await _amplifyAuth.signOut();
      setState(() {
        _authState = 'Signed Out';
        _accessToken = '';
      });
      safePrint('Signed out successfully');
    } on AuthException catch (e) {
      safePrint('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Cognito Custom Auth Flow')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Authentication State: $_authState',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              if (_authState == 'Signed Out' || _authState == 'Sign In Failed')
                ElevatedButton(
                  onPressed: _signInWithHostedUI,
                  child: const Text('Sign In with Hosted UI'),
                ),
              if (_authState == 'OTP Required' ||
                  _authState == 'OTP Failed') ...[
                const Text(
                  'An OTP has been sent to your email/phone. Please enter it below.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _confirmOtp,
                  child: const Text('Confirm OTP'),
                ),
              ],
              if (_authState == 'Signed In') ...[
                const Text(
                  'You are successfully signed in!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Access Token: $_accessToken',
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 10),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signOut,
                  child: const Text('Sign Out'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
