import 'package:flutter/material.dart';
import 'package:my_tester/view/screen/authentication/login/login_page.dart';
import 'package:provider/provider.dart';

import '../../../../controller/authentication/registration_provider.dart';
import '../login/layout/login_image.dart';
import 'layout/textfield_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const LoginImage(), // Separate image widget
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RegistrationTextFields(
                    formKey: registrationProvider.registrationKey),
              ),

              const SizedBox(height: 20),
              // "OR" Divider Row
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "OR",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Handle forgot password action
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Text("Don't have an account? Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
