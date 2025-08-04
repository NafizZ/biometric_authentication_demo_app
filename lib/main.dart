import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'amplifyconfiguration.dart'; // this is the file you showed

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      await Amplify.configure(amplifyconfig);
      setState(() => _amplifyConfigured = true);
    } on AmplifyAlreadyConfiguredException {
      setState(() => _amplifyConfigured = true); // okay if already configured
    } catch (e) {
      print('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AWS Hosted UI Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Center(
          child: Column(
            children: [
              _amplifyConfigured
                  ? ElevatedButton(
                      onPressed: _signInWithWebUI,
                      child: const Text("Sign In with AWS Hosted UI"),
                    )
                  : const CircularProgressIndicator(),

              ElevatedButton(
                onPressed: _signOut,
                child: const Text("Sign out"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithWebUI() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI();
      print('Sign-in success: ${result.isSignedIn}');
    } on AuthException catch (e) {
      print('Sign-in failed: ${e.message}');
    }
  }

  Future<void> _signOut() async {
    try {
      await Amplify.Auth.signOut();
      print('User signed out successfully');
    } on AuthException catch (e) {
      print('Sign out failed: ${e.message}');
    }
  }
}
