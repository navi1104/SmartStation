import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:smart_station/customer/controllers/requestController.dart';
import 'package:smart_station/customer/views/loginScreen.dart';
import 'package:smart_station/main.dart';

import '../models/vehicleModel.dart';
import '../views/homePage.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      Get.put(RequestController());
      Get.offAll(() => HomePage());
    } else {
      Get.offAll(() => MainScreen());
    }
  }

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> loginWithPhone(String phoneNumber) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('customers')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isEmpty) {
      Get.snackbar('Error', 'Phone number not found');
    } else {
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {
            // Auto-sign-in the user on Android devices only.
            _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              Get.snackbar('Error', 'The provided phone number is not valid');
            } else {
              Get.snackbar('Error', e.message!);
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            Get.snackbar(
              "Success",
              "OTP Sent to your phone",
              snackPosition: SnackPosition.BOTTOM,
            );
            String smsCode = await getSMSCode(); // get SMS code from user input
            AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: smsCode,
            );
            UserCredential userCredential =
                await _auth.signInWithCredential(credential);

            // create customer document in firestore
            Get.put(RequestController());
            Get.offAll(() => HomePage());
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          timeout: Duration(seconds: 60),
        );
      } catch (e) {
        Get.snackbar(
            "Error", "Failed to sign in with phone number: ${e.toString()}");
      }
    }
  }

  Future<void> signUp(String name, String phoneNumber, Vehicle vehicle) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('customers')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.isNotEmpty) {
      Get.snackbar('Error', 'Phone number already in use');
    } else {
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: ((phoneAuthCredential) => {}),
          verificationFailed: ((FirebaseAuthException e) => {}),
          codeSent: (String verificationId, int? resendToken) async {
            Get.snackbar(
              "Success",
              "OTP Sent to your phone",
              snackPosition: SnackPosition.BOTTOM,
            );
            String smsCode = await getSMSCode(); // get SMS code from user input
            AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: smsCode,
            );
            UserCredential userCredential =
                await _auth.signInWithCredential(credential);

            // create customer document in firestore
            FirebaseFirestore.instance
                .collection('customers')
                .doc(userCredential.user!.uid)
                .set({
              'name': name,
              'phoneNumber': phoneNumber,
              'vehicle': vehicle.toJson(),
            });
            Get.put(RequestController());
            Get.to(() => HomePage());
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", "Failed to sign up: ${e.message}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> getSMSCode() async {
    String smsCode = '';
    await Get.dialog(
      AlertDialog(
        title: Text("Enter OTP"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (value) {
                smsCode = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(() => LoginScreen());
            },
            child: Text("CANCEL"),
          ),
          TextButton(
            onPressed: () {
              if (smsCode.length == 6) {
                Get.back();
              } else {
                Get.snackbar(
                  "Error",
                  "SMS Code must be 6 digits",
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: Text("OK"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    return smsCode;
  }
}
