import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:currency_converter/login_signup/common/custom_input_field.dart';
import 'package:currency_converter/login_signup/common/page_header.dart';
import 'package:currency_converter/login_signup/forget_password_page.dart';
import 'package:currency_converter/login_signup/signup_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:currency_converter/login_signup/common/page_heading.dart';
import 'package:currency_converter/login_signup/common/custom_form_button.dart';
import 'package:currency_converter/view/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLoginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submitting data..')),
        );

        UserCredential userCredential;
        if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
          userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
        } else {
          // Anonymous login if email and password are empty
          userCredential = await FirebaseAuth.instance.signInAnonymously();
        }

        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );

        // Navigate to the HomeScreen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );

      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided.';
        } else {
          errorMessage = 'An error occurred. Please try again.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF72585), //Header background color
        body: Column(
          children: [
            const PageHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        const PageHeading(title: 'Log-in'),
                        CustomInputField(
                          labelText: 'Email',
                          hintText: 'Your email id',
                          controller: _emailController,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Email is required!';
                            }
                            if (!EmailValidator.validate(textValue)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          labelText: 'Password',
                          hintText: 'Your password',
                          obscureText: true,
                          controller: _passwordController,
                          suffixIcon: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: size.width * 0.80,
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPasswordPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                color: Color(0xff939393),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomFormButton(
                          innerText: 'Login',
                          onPressed: _handleLoginUser,
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account ? ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff939393),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign-up',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: TextButton(
                            onPressed: () async {
                              await _handleGuestLogin();
                            },
                            child: const Text('Login as Guest'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleGuestLogin() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging in as guest..')),
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Guest Login successful!')),
      );

      // Navigate to the HomeScreen after successful guest login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Guest Login failed. Please try again.')),
      );
    }
  }
}
