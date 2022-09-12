import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../common/widgets/custom_password_textfield.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool loading = false;
  bool passwordVisible = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
    );
    setState(() {
      loading = true;
    });
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loader()
        : Scaffold(
            backgroundColor: GlobalVariables.greyBackgroundColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListTile(
                      tileColor: _auth == Auth.signup
                          ? GlobalVariables.backgroundColor
                          : GlobalVariables.greyBackgroundColor,
                      title: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                      ),
                    ),
                    if (_auth == Auth.signup)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        color: GlobalVariables.backgroundColor,
                        child: Form(
                          key: _signUpFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _usernameController,
                                hintText: 'Username',
                                labelText: 'Username',
                                textInputType: TextInputType.name,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email',
                                labelText: 'Email',
                                textInputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 10),
                              CustomPasswordTextField(
                                  passwordController: _passwordController,
                                  passwordVisible: !passwordVisible,
                                  togglePassword: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  }),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: 'Sign Up',
                                onTap: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ListTile(
                      tileColor: _auth == Auth.signin
                          ? GlobalVariables.backgroundColor
                          : GlobalVariables.greyBackgroundColor,
                      title: const Text(
                        'Sign-In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                      ),
                    ),
                    if (_auth == Auth.signin)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        color: GlobalVariables.backgroundColor,
                        child: Form(
                          key: _signInFormKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email',
                                labelText: 'Email',
                                textInputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 10),
                              CustomPasswordTextField(
                                  passwordController: _passwordController,
                                  passwordVisible: !passwordVisible,
                                  togglePassword: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  }),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: 'Sign In',
                                onTap: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
  }
}
