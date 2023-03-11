import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  String generateSmsCode() {
  Random random = Random();
  int smsCode = random.nextInt(999999);
  return smsCode.toString().padLeft(6, '0');
}

  Future<void> signUp(String name, String phoneNumber, String vehicleName, String licensePlate, String vehicleType, String vehicleSubType) async {
    try {
      // First sign up the user with Firebase Auth using phone number and OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: generateSmsCode());
      UserCredential authResult = await _auth.signInWithCredential(credential);

      // Then create a user document in Firestore with the user's data
      DocumentReference userDocRef = _db.collection('customers').doc(authResult.user!.uid);
      await userDocRef.set({
        'name': name,
        'phoneNumber': phoneNumber,
        'vehicle': {
          'vehicleName': vehicleName,
          'licensePlate': licensePlate,
          'vehicleType': vehicleType,
          'vehicleSubType': vehicleSubType,
        },
      });
    } catch (error) {
      Get.snackbar('Sign Up Failed', error.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

 



  Future<void> login(String phoneNumber) async {
    try {
      // Sign in the user with Firebase Auth using phone number and OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: generateSmsCode());
      await _auth.signInWithCredential(credential);
    } catch (error) {
      Get.snackbar('Login Failed', error.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      Get.snackbar('Sign Out Failed', error.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
