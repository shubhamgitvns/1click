import 'package:flutter/material.dart';
import 'package:my_tester/view/screen/dashboard_screens/dashboard.dart';

import '../../utility/local_storage.dart';
import 'authentication/login/login_page.dart';

// Replace with your actual home screen widget.

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller for 3 seconds.
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // Create a fade-in animation.
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation.
    _controller.forward();

    // Listen for when the animation is complete and then navigate to HomePage.
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        String? token = await StorageHelper.getToken();
        // Navigate to screen after splash screen
        //fetchUserData is localy store login token and vender id
        if (token != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black87,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated logo or icon
              Icon(
                Icons.touch_app, // Represents "Click"
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              // App name "1Click"
              Text(
                '1Click',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
