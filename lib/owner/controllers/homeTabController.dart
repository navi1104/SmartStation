import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_station/owner/controllers/oAuthController.dart';

import '../models/ownerModel.dart';

OwnerAuthController authController = Get.find();
var ownerData = {}.obs; // Move the initialization of `ownerData` here

class HomeTabController extends GetxController {
  Future<void> getOwner() async {
    var docSnapshot = await FirebaseFirestore.instance
        .collection('owners')
        .doc('${authController.firebaseUser.value!.uid}')
        .get();

    print('${docSnapshot.data()}');
    if (docSnapshot.exists) {
      ownerData.value = docSnapshot.data() ??
          {}; // Update the observable Map with the document data
    }
  }
}
