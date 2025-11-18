import 'package:flutter/material.dart';
import 'registration_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool _showError = false;

  String? _emailErrorCode;
  String? _passwordErrorCode;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Simple validation - in real app, call backend
      if (_emailController.text == 'qwerty@qwe.qwe' &&
          _passwordController.text == 'qwertyuioP_1') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        setState(() {
          _showError = true;
          _errorMessage = 'Incorrect login or password';
        });
      }
    }
  }

  bool _isLoginButtonEnabled() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  // Функція для відображення тексту помилки з ключем
  Widget _errorText(String? errorCode) {
    switch (errorCode) {
      case 'email_required':
        return const Text(
          'Email is required',
          key: Key('emailError'),
          style: TextStyle(color: Colors.red),
        );
      case 'email_invalid':
        return const Text(
          'Enter a valid email',
          key: Key('emailError'),
          style: TextStyle(color: Colors.red),
        );
      case 'password_required':
        return const Text(
          'Password is required',
          key: Key('passwordError'),
          style: TextStyle(color: Colors.red),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page', key: Key('loginPageAppBarTitle')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            key: const Key('loginPageMainColumn'),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                key: Key('loginTitle'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                key: const Key('emailField'),
                controller: _emailController,
                decoration: InputDecoration(
                  label: Text('Email', key: Key('emailFieldLabel')),
                  hint: Text('Enter your email', key: Key('emailFieldHint')),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      _emailErrorCode = 'email_required';
                    });
                    return '';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                    setState(() {
                      _emailErrorCode = 'email_invalid';
                    });
                    return '';
                  }
                  setState(() {
                    _emailErrorCode = null;
                  });
                  return null;
                },
                onChanged: (_) {
                  setState(() {
                    _showError = false;
                    _emailErrorCode = null;
                  });
                },
              ),
              if (_emailErrorCode != null) _errorText(_emailErrorCode),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('passwordField'),
                controller: _passwordController,
                decoration: InputDecoration(
                  label: Text('Password', key: Key('passwordFieldLabel')),
                  hint: Text(
                    'Enter your password',
                    key: Key('passwordFieldHint'),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      _passwordErrorCode = 'password_required';
                    });
                    return '';
                  }
                  setState(() {
                    _passwordErrorCode = null;
                  });
                  return null;
                },
                onChanged: (_) {
                  setState(() {
                    _showError = false;
                    _passwordErrorCode = null;
                  });
                },
              ),
              if (_passwordErrorCode != null) _errorText(_passwordErrorCode),
              if (_showError)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    key: const Key('loginErrorMessage'),
                  ),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                key: const Key('loginButton'),
                onPressed: _isLoginButtonEnabled() ? _login : null,
                child: const Text('Login', key: Key('loginButtonText')),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      key: Key('signUpLink'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
