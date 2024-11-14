import 'package:flutter/material.dart';
import 'package:lab12/api_servise.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      apiService.sendRequest(
        'signup',
        {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Реєстрація")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Ім`я користувача'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введіть ваше ім`я';
                  return null;
                },
              ),
              SizedBox(height: 16),
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
                onPressed: () => _register(context),
                child: Text("Реєстрація"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Авторизація"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
