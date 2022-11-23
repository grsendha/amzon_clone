// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global%20variables.dart';
import 'package:amazon_clone/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/custom_textfield.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String routeName = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() {
    print('signup user');
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() {
    authService.signIpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text('Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(
                    () {
                      _auth = val!;
                    },
                  );
                },
                // onChanged:
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(_nameController, 'Name', false),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(_emailController, 'Email', false),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(_passwordController, 'Passwordd', true),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        'SignUp',
                        () {
                          if (_signUpFormKey.currentState!.validate()) {
                            signUpUser();
                          }
                          // signUpUser();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ListTile(
              title: const Text('SignIn',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(
                    () {
                      _auth = val!;
                    },
                  );
                },
                // onChanged:
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(_emailController, 'Email', false),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(_passwordController, 'Password', true),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton('SignIn', () {
                        if(_signInFormKey.currentState!.validate()){
                          signInUser();
                        }
                      }),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
