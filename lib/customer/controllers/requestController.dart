import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/controllers/custAuthController.dart';
import 'package:smart_station/customer/views/homePage.dart';
import 'package:smart_station/customer/views/paymentsPage.dart';

import '../../common models/requestModel.dart';

class RequestController extends GetxController {
  CollectionReference requestsCollection =
      FirebaseFirestore.instance.collection('requests');
  AuthController _authController = Get.find();
  var customerData = {}.obs;

  Future<void> getCustomer() async {
    var docSnapshot = await FirebaseFirestore.instance
        .collection('customers')
        .doc('${_authController.firebaseUser.value!.uid}')
        .get();

    print('${docSnapshot.data()}');
    if (docSnapshot.exists) {
      customerData.value = docSnapshot.data() ??
          {}; // Update the observable Map with the document data
    }
  }

  Future<void> sendRequest(String owner_uid, String service) async {
    await getCustomer();
    Request request = Request(
        name: customerData["name"],
        id: _authController.firebaseUser.value!.uid,
        service: service,
        isAccepted: false,
        isRejected: false,
        exit: false
        );

    try {
      await requestsCollection
          .doc(owner_uid)
          .collection('user_requests')
          .doc(_authController.firebaseUser.value!.uid)
          .set(request.toJson());
      Get.snackbar('Success', 'Request sent and stored successfully');
      // Start listening to changes in the document
      listenToRequest(owner_uid);
    } catch (error) {
      Get.snackbar('Error', 'Failed to send request: $error');
    }
  }

  void listenToRequest(String owner_uid) {
    requestsCollection
        .doc(owner_uid)
        .collection('user_requests')
        .doc(_authController.firebaseUser.value!.uid)
        .snapshots()
        .listen((docSnapshot) {
      if (docSnapshot.exists) {
        // Get the updated request data from the document
        Request request =
            Request.fromJson(docSnapshot.data() as Map<String, dynamic>);
        // Check if the request has been accepted
        if (request.isAccepted) {
          // Navigate to the payments page
          Get.off(() => PaymentsPage());
        } else if (request.isRejected) {
          Get.off(() => HomePage());
          Get.snackbar("Sorry", "Your request has been rejected by the vendor");
        }
      }
    });
  }
}
