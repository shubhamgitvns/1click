import 'package:flutter/material.dart';

import '../authentication/login/login_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Profile Screen",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}
