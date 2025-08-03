import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController _controller = AuthController();
  String _status = 'Not Authenticated';

  Future<void> _handleAuthentication() async {
    final result = await _controller.authenticate();
    setState(() {
      _status = result.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Auth Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _handleAuthentication,
              icon: const Icon(Icons.fingerprint),
              label: const Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }
}
