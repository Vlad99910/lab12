import 'package:flutter/material.dart';
import 'package:lab12/api_servise.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      apiService.sendRequest(
        'login',
        {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your password';
                  if (value.length < 7) return 'Password must be at least 7 characters long';
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text("Login"),
              ),

              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text("Sign up"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/reset-password'),
                child: Text("Reset Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}