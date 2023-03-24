import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_station/common%20models/requestModel.dart';

class RequestListController extends GetxController {
  late CollectionReference requestsCollection;
  late Stream<QuerySnapshot> requestsStream;
  late List<Request> requests;

  void init(String uid) {
    requestsCollection = FirebaseFirestore.instance.collection('requests/$uid/user_requests');
    requestsStream = requestsCollection.snapshots();
    requests = [];
    requestsStream.listen((querySnapshot) {
      requests = querySnapshot.docs.map((doc) => Request.fromSnapshot(doc)).toList();
      update();
    });
  }

  Future<void> acceptRequest(String requestId) async {
    try {
      await requestsCollection.doc(requestId).update({'isAccepted': 'true'});
      Get.snackbar('Success', 'Request accepted');
    } catch (error) {
      Get.snackbar('Error', 'Failed to accept request: $error');
    }
  }

  Future<void> deleteRequest(String requestId) async {
    try {
      await requestsCollection.doc(requestId).delete();
      Get.snackbar('Success', 'Request deleted');
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete request: $error');
    }
  }
}


