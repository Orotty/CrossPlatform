import 'package:flutter/material.dart';

bool validateEmail(String email) => RegExp(r'\S+@\S+\.\S+').hasMatch(email);
bool validatePassword(String password) => password.length >= 6;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';
  bool switchValue = false;

  void handleLogin() {
    final email = emailController.text;
    final password = passwordController.text;

    if (!validateEmail(email)) {
      setState(() => message = 'Invalid email format');
    } else if (!validatePassword(password)) {
      setState(() => message = 'Password must be at least 6 characters');
    } else {
      setState(() => message = 'Login successful!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Test App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: handleLogin,
              child: Text('Login'),
            ),
            Text(message),
            SwitchListTile(
              title: Text('Toggle Switch'),
              value: switchValue,
              onChanged: (bool value) {
                setState(() {
                  switchValue = value;
                  message = 'Switch is ${value ? "ON" : "OFF"}';
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: LoginScreen()));
}
