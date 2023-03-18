import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/controllers/custAuthController.dart';
import 'package:smart_station/owner/controllers/oAuthController.dart';
import 'package:smart_station/owner/views/oSignupScreen.dart';

import 'customer/views/signUpScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Name'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.put(OwnerAuthController());
                Get.to(() => OwnerRegistrationForm());
              },
              child: Text('Owner'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.put(AuthController());
                Get.to(() => CustomerSignupScreen());
              },
              child: Text('Customer'),
            ),
          ],
        ),
      ),
    );
  }
}

//use mvc architecture with getx.
