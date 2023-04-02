import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/controllers/custAuthController.dart';

import '../../common models/requestModel.dart';
import 'oAuthController.dart';

class RequestListController extends GetxController {
  OwnerAuthController _ownerAuthController = Get.find();
  CollectionReference requestsCollection =
      FirebaseFirestore.instance.collection('requests');
  var requestsList = <Request>[].obs;

  @override
  void onInit() async {
    super.onInit();
    listenToRequest(_ownerAuthController.firebaseUser.value!.uid);
  }

  void listenToRequest(String owner_uid) {
    requestsCollection
        .doc(owner_uid)
        .collection('user_requests')
        .snapshots()
        .listen((snapshot) {
      requestsList.clear();
      snapshot.docs.forEach((doc) {
        Request request = Request.fromJson(doc.data());
        requestsList.add(request);
      });
    });
  }

  Future<void> acceptRequest(String user_uid) async {
    try {
      await requestsCollection
          .doc(_ownerAuthController.firebaseUser.value!.uid)
          .collection('user_requests')
          .doc(user_uid)
          .update({'isAccepted': true});
    } catch (error) {
      Get.snackbar('Error', 'Failed to accept request: $error');
    }
  }

  Future<void> rejectRequest(String user_uid) async {
    try {
      await requestsCollection
          .doc(_ownerAuthController.firebaseUser.value!.uid)
          .collection('user_requests')
          .doc(user_uid)
          .update({'isRejected': true});
      await requestsCollection
          .doc(_ownerAuthController.firebaseUser.value!.uid)
          .collection('user_requests')
          .doc(user_uid)
          .delete();
      requestsList.removeWhere((request) => request.id == user_uid);
    } catch (error) {
      Get.snackbar('Error', 'Failed to reject request: $error');
    }
  }
}
