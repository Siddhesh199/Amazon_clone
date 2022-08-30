import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  final bool passwordVisible;
  final VoidCallback togglePassword;
  const CustomPasswordTextField({
    Key? key,
    required this.passwordController,
    required this.passwordVisible,
    required this.togglePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: passwordController,
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        labelText: 'Password',
        hintText: 'Enter your password',
        // Here is key idea
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: togglePassword,
        ),
      ),
    );
  }
}
