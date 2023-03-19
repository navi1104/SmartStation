import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_station/owner/views/oSignupScreen.dart';

import '../controllers/oAuthController.dart';

class OwnerLoginScreen extends StatelessWidget {
  final OwnerAuthController _authController = Get.find();

  final TextEditingController _phoneNumberController = TextEditingController();

  OwnerLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(

              onPressed: () {
                _authController.loginWithPhone("+91${_phoneNumberController.text}");
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Text("Don't have an account? Sign-up"),
              onTap: () {
                Get.offAll(() => OwnerRegistrationForm());
              },
            )
          ],
        ),
      ),
    );
  }
}
