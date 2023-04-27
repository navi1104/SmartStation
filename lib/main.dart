import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/controllers/custAuthController.dart';
import 'package:smart_station/customer/views/homePage.dart';
import 'package:smart_station/owner/controllers/oAuthController.dart';
import 'package:smart_station/owner/views/oSignupScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'customer/controllers/requestController.dart';
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
      debugShowCheckedModeBanner: false,
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
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(image: AssetImage('images/image-removebg-preview.png')),
            Text(
              'SmartStation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('WELCOME!',
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    speed: Duration(
                      milliseconds: 200,
                    )),
              ],
              isRepeatingAnimation: true,
            ),
            SizedBox(
              height: 20,
            ),
            Text('HELLO!'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 80,
                width: 400,
                child: ElevatedButton(
                    onPressed: () {
                      Get.put(OwnerAuthController());
                      Get.to(() => OwnerRegistrationForm());
                    },
                    child: Text(
                      'Owner',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)))),
              ),
            ),
            //SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 80.0,
                width: 400.0,
                child: ElevatedButton(
                    onPressed: () {
                      Get.put(AuthController());
                      Get.put(RequestController());
                      Get.to(() => CustomerSignupScreen());
                    },
                    child: Text(
                      'Customer',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)))),
              ),
            ),
            SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
