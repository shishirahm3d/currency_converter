import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:currency_converter/login_signup/common/custom_form_button.dart';
import 'package:currency_converter/login_signup/common/page_header.dart';
import 'package:currency_converter/login_signup/common/page_heading.dart';
import 'package:currency_converter/login_signup/login_page.dart';
import 'package:currency_converter/login_signup/common/custom_input_field.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  final _forgetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _handleForgetPassword() async {
    if (_forgetPasswordFormKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF72585),
        body: Column(
          children: [
            const PageHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _forgetPasswordFormKey,
                    child: Column(
                      children: [
                        const PageHeading(title: 'Forgot password',),
                        CustomInputField(
                          labelText: 'Email',
                          hintText: 'Your email id',
                          isDense: true,
                          validator: (textValue) {
                            if(textValue == null || textValue.isEmpty) {
                              return 'Email is required!';
                            }
                            if(!EmailValidator.validate(textValue)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          controller: _emailController,
                        ),
                        const SizedBox(height: 20,),
                        CustomFormButton(innerText: 'Submit', onPressed: _handleForgetPassword,),
                        const SizedBox(height: 20,),
                        Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()))
                            },
                            child: const Text(
                              'Back to login',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff939393),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
}
