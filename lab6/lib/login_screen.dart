import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleLogin,
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            Text(message),
          ],
        ),
      ),
    );
  }
}

bool validateEmail(String email) =>
    RegExp(r'\S+@\S+\.\S+').hasMatch(email);

bool validatePassword(String password) =>
    password.length >= 6;
