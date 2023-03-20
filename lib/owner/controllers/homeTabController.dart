import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/controllers/custAuthController.dart';

import '../models/ownerModel.dart';

AuthController authController = Get.find();

class HomeTabController extends GetxController {
  Future<Owner?> fetchOwner(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('owners').doc(uid).get();
      if (snapshot.exists) {
        Owner owner = Owner.fromJson(snapshot as Map<String, dynamic>);
        return owner;
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }
}
