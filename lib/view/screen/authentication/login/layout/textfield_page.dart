import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../controller/authentication/login_provider.dart';
import '../../../../../core_widget/common_button.dart';
import 'checkbox_page.dart';

class LoginTextFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const LoginTextFields({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  State<LoginTextFields> createState() => _LoginTextFieldsState();
}

class _LoginTextFieldsState extends State<LoginTextFields> {
  bool _obscureText = true;
  bool _termsError = false; // Local state for showing checkbox error

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // Gmail Input Field
          TextFormField(
            controller: loginProvider.emailController,
            decoration: InputDecoration(
              labelText: 'Enter Gmail',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Password Input Field with toggle visibility
          TextFormField(
            controller: loginProvider.passwordController,
            decoration: InputDecoration(
              labelText: 'Enter Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoginCheckbox(
                isChecked: loginProvider.checkedValue,
                onChanged: (value) {
                  setState(() {
                    loginProvider.checkedValue = value ?? false;
                    _termsError = false; // Clear error when checkbox changes
                  });
                  loginProvider.notifyListeners();
                },
              ),
              TextButton(
                onPressed: () {
                  print("Forgot password clicked");
                },
                child: const Text("Forgot Password?"),
              ),
            ],
          ),
          // Error message for checkbox if not ticked
          if (_termsError)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please tick the terms & Condition Box",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ),
          const SizedBox(height: 20),
          // CommonButton ke onTap mein form validation & checkbox check
          CommonButton(
            onTap: () {
              if (widget.formKey.currentState!.validate() &&
                  loginProvider.checkedValue) {
                loginProvider.onLogin(context);
              } else {
                setState(() {
                  _termsError = !loginProvider.checkedValue;
                });
              }
            },
            buttonText: 'Sign In',
          ),
        ],
      ),
    );
  }
}
