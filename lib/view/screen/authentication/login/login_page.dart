import 'package:flutter/material.dart';
import 'package:my_tester/controller/authentication/registration_provider.dart';
import 'package:my_tester/controller/dashboard/dashboard_provider.dart';
import 'package:my_tester/view/screen/authentication/registration/registration.dart';
import 'package:my_tester/view/screen/dashboard_screens/dashboard.dart';
import 'package:provider/provider.dart';

import '../../../../controller/authentication/login_provider.dart';
import 'layout/login_image.dart';
import 'layout/textfield_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const LoginImage(), // Separate image widget
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LoginTextFields(formKey: loginProvider.loginKey),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (_) => DashboardProvider()),
                        ],
                        child:
                            const DashboardScreen(), // Yahan HomeScreen ya Dashboard widget pass karein.
                      ),
                    ),
                    (Route<dynamic> route) =>
                        false, // Sabhi previous routes ko remove kare.
                  );
                },
                child: const Text("Continue as? Guest"),
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (_) => RegistrationProvider()),
                        ],
                        child:
                            const RegistrationPage(), // Yahan HomeScreen ya Dashboard widget pass karein.
                      ),
                    ),
                    (Route<dynamic> route) =>
                        false, // Sabhi previous routes ko remove kare.
                  );
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
