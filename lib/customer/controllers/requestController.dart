import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/controllers/custAuthController.dart';

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
  Future<void> sendRequest(String owner_uid ,String service) async {
    await getCustomer();
    Request request =
        Request(name: customerData["name"], id: _authController.firebaseUser.value!.uid, service: service, isAccepted: false);

    try {
      await requestsCollection
          .doc(owner_uid)
          .collection('user_requests').doc(_authController.firebaseUser.value!.uid)
          .set(request.toJson());
      Get.snackbar('Success', 'Request sent and stored successfully');
    } catch (error) {
      Get.snackbar('Error', 'Failed to send request: $error');
    }







     
  }
}
