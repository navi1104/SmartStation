import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/controllers/custAuthController.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _authController.signOut();
        },
      ),
      body: SafeArea(
          child: Text("Customer home " +
              _authController.firebaseUser.value!.uid.toString())),
    );
  }
}
