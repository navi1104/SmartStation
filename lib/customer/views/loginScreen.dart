import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_station/customer/views/signUpScreen.dart';

import '../controllers/custAuthController.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Phone Number',
                labelStyle: MaterialStateTextStyle.resolveWith(
                  (states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).colorScheme.error
                        : Colors.orange;
                    return TextStyle(color: color, letterSpacing: 1.3);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _authController.loginWithPhone(_phoneNumberController.text);
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Text("Don't have an account? Sign-up"),
              onTap: () {
                Get.offAll(() => CustomerSignupScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
