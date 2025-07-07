import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utility/app_constant.dart';
import '../../utility/local_storage.dart';
import '../../view/screen/authentication/login/login_page.dart';

class RegistrationProvider with ChangeNotifier {
  GlobalKey<FormState> registrationKey = GlobalKey<FormState>();

  TextEditingController confpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  // final FocusNode emailFocus = FocusNode();
  // final FocusNode passwordFocus = FocusNode();
  // final FocusNode confpasswordFocus = FocusNode();
  bool isNewPassword = true;

  // **Registration button click**
  Future<void> onRegistration(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (registrationKey.currentState!.validate()) {
      await registerUser(context); // Corrected API call
      registration(context);
    }
  }

  Future<void> registerUser(BuildContext context) async {
    final url = Uri.parse("${AppConstant.baseUrl}${AppConstant.registerUrl}");
    final vendorId = await StorageHelper.getVendorId();

    final Map<String, dynamic> requestBody = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "confirmPassword": confpasswordController.text,
      "vendorId": vendorId,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      final responseJson = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final successMessage = responseJson['data']?['message'] ?? "You are successfully registered!";
        if (context.mounted) {
          showMaterialBanner(context, "Success", successMessage, isError: false);
          onBack();
        }
      } else {
        final errorMessage = responseJson['error']?['message'] ?? "Registration failed! Try again.";
        if (context.mounted) {
          showMaterialBanner(context, "Failed", errorMessage, isError: true);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showMaterialBanner(context, "Error", "Something went wrong! Check your internet.", isError: true);
      }
    }
  }
  //registration
  registration(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
    notifyListeners();
    onBack();
  }
  void showMaterialBanner(BuildContext context, String title, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        leading: Icon(isError ? Icons.error : Icons.check_circle, color: isError ? Colors.red : Colors.green),
        backgroundColor: isError ? Colors.red.shade50 : Colors.green.shade50,
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: const Text("DISMISS"),
          ),
        ],
      ),
    );
  }

  //onBack clear
  onBack() {
    emailController.clear();
    passwordController.clear();
    confpasswordController.clear();
    // passwordController.text ='';
    notifyListeners();
  }

  //new password see tap
  newPasswordSeenTap() {
    isNewPassword = !isNewPassword;
    notifyListeners();
  }
}
