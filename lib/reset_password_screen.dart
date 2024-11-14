import 'package:flutter/material.dart';
import 'package:lab12/api_servise.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final ApiService apiService = ApiService();

  void _resetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      apiService.sendRequest(
        'reset',
        {
          'email': emailController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
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
              ElevatedButton(
                onPressed: () => _resetPassword(context),
                child: Text("Reset Password"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Back to Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
