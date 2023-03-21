import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_station/owner/controllers/homeTabController.dart';
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
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Parking Price (Rs./hr)',
                labelStyle: MaterialStateTextStyle.resolveWith(
                  (states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).colorScheme.error
                        : Colors.lightGreen;
                    return TextStyle(color: color, letterSpacing: 1.3);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.put(HomeTabController());
                _authController
                    .loginWithPhone("+91${_phoneNumberController.text}");
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Center(child: Text("Don't have an account? Sign-up")),
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
