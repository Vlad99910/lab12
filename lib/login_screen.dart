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
      appBar: AppBar(title: Text("Авторизація")),
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
                  if (value == null || value.isEmpty) return 'Будь ласка, введіть Email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Ви ввели Email не правильно';
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Пароль'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Будь ласка, введіть пароль';
                  if (value.length < 7) return 'Пароль не може бути меншим як 7 символів';
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text("Авторизація"),
              ),

              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text("Реєстрація"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/reset-password'),
                child: Text("Забули пароль?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
