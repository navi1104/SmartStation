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

  void updateParkingPrice(double newPrice) {
    if (ownerData['smartStation']['facilities']['parkingPrice'] != null) {
      ownerData['smartStation']!['facilities']!['parkingPrice'] = newPrice;
      FirebaseFirestore.instance
          .collection('owners')
          .doc(authController.firebaseUser.value!.uid)
          .update({'smartStation.facilities.parkingPrice': newPrice});
    }
  }

  void updateChargingPrice(double newPrice) {
    if (ownerData['smartStation']['facilities']['chargingPrice'] != null) {
      ownerData['smartStation']!['facilities']!['chargingPrice'] = newPrice;
      FirebaseFirestore.instance
          .collection('owners')
          .doc(authController.firebaseUser.value!.uid)
          .update({'smartStation.facilities.chargingPrice': newPrice});
    }
  }

  void updateChargingSatus() {
    ownerData["smartStation"]["facilities"].update(
        "chargingAvailable",
        (value) =>
            !ownerData["smartStation"]["facilities"]["chargingAvailable"]);
    FirebaseFirestore.instance
        .collection('owners')
        .doc(authController.firebaseUser.value!.uid)
        .update({
      'smartStation.facilities.chargingAvailable':
          ownerData["smartStation"]["facilities"]["chargingAvailable"] ?? false
    });
  }

  void updateSmartStationAvailability() {
    ownerData["smartStation"].update(
        "isAvailable", (value) => !ownerData["smartStation"]["isAvailable"]);
    FirebaseFirestore.instance
        .collection('owners')
        .doc(authController.firebaseUser.value!.uid)
        .update({
      'smartStation.isAvailable':
          ownerData["smartStation"]["isAvailable"] ?? false
    });
  }
}
