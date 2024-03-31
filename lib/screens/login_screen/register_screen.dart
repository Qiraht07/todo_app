import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/screens/login_screen/login_screen.dart';

///This code defines a stateful widget called RegisterScreen.
///It has a static constant variable id which holds the identifier for this screen.
///The constructor takes an optional key parameter.

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

///This section defines the state class _RegisterScreenState.
///It includes a form key for form validation, text controllers for email and password inputs,
///and an instance of FirebaseAuth for user authentication.
///The dispose method is overridden to dispose of the text controllers when the state is disposed.

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  ///This part includes the UI for the register screen. It contains a form with text form fields for email and password inputs.
  ///The email field is validated to ensure it's not empty, and the password field is validated to ensure it's at least 6 characters long.
  ///An elevated button is used to trigger user registration. Upon successful registration, the user is navigated to the login screen.
  ///If an error occurs during registration, a snack bar is shown displaying the error message.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Insert email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Insert password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (value.length < 6) {
                    return 'Password should be at least 6 characters';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _auth.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text
                ).then((value) {
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                }).onError((error, stackTrace){
                  var snackBar = SnackBar(
                    duration: const Duration(milliseconds: 5000),
                    content: Text(
                      'An Error occurred: $error',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.redAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
