import 'package:flutter/material.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    setState(() {
      _emailError = _validateEmail(_emailController.text);
      _passwordError = _validatePassword(_passwordController.text);
      _confirmPasswordError = _validateConfirmPassword(
        _confirmPasswordController.text,
      );
    });

    if (_emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
          key: Key('registrationSuccessSnackbar'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) return 'email_required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value))
      return 'email_invalid';
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return 'password_required';
    if (value.length < 8) return 'password_length';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'password_uppercase';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'password_number';
    if (!RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]').hasMatch(value))
      return 'password_special';
    return null;
  }

  String? _validateConfirmPassword(String value) {
    if (value.isEmpty) return 'confirm_required';
    if (value != _passwordController.text) return 'confirm_mismatch';
    return null;
  }

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
      case 'password_length':
        return const Text(
          'Password must be at least 8 characters',
          key: Key('passwordError'),
          style: TextStyle(color: Colors.red),
        );
      case 'password_uppercase':
        return const Text(
          'Password must contain at least one uppercase letter',
          key: Key('passwordError'),
          style: TextStyle(color: Colors.red),
        );
      case 'password_number':
        return const Text(
          'Password must contain at least one number',
          key: Key('passwordError'),
          style: TextStyle(color: Colors.red),
        );
      case 'password_special':
        return const Text(
          'Password must contain at least one special character',
          key: Key('passwordError'),
          style: TextStyle(color: Colors.red),
        );
      case 'confirm_required':
        return const Text(
          'Confirm password is required',
          key: Key('passwordConfirmError'),
          style: TextStyle(color: Colors.red),
        );
      case 'confirm_mismatch':
        return const Text(
          'Passwords do not match',
          key: Key('passwordConfirmError'),
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
        title: const Text(
          'Registration Page',
          key: Key('registrationPageAppBarTitle'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          key: const Key('registrationPageMainColumn'),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              key: Key('registrationTitle'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              key: const Key('registrationEmailField'),
              controller: _emailController,
              decoration: const InputDecoration(
                label: Text('Email', key: Key('registrationEmailFieldLabel')),
                hint: Text(
                  'Enter your email',
                  key: Key('registrationEmailFieldHint'),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            _errorText(_emailError),
            const SizedBox(height: 16),
            TextField(
              key: const Key('registrationPasswordField'),
              controller: _passwordController,
              decoration: const InputDecoration(
                label: Text(
                  'Password',
                  key: Key('registrationPasswordFieldLabel'),
                ),
                hint: Text(
                  'Enter your password',
                  key: Key('registrationPasswordFieldHint'),
                ),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            _errorText(_passwordError),
            const SizedBox(height: 16),
            TextField(
              key: const Key('registrationConfirmPasswordField'),
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                label: Text(
                  'Confirm Password',
                  key: Key('registrationConfirmPasswordFieldLabel'),
                ),
                hint: Text(
                  'Re-enter your password',
                  key: Key('registrationConfirmPasswordFieldHint'),
                ),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            _errorText(_confirmPasswordError),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('registerButton'),
              onPressed: _register,
              child: const Text('Register', key: Key('registerButtonText')),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    key: Key('signInLink'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
