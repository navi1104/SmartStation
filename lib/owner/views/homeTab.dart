import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/homeTabController.dart';
import '../controllers/oAuthController.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);
  OwnerAuthController ownerAuthController = Get.find();
  HomeTabController homeTabController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ownerAuthController.firebaseUser.value == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (ownerData.isEmpty) {
        // Check if `ownerData` is empty
        homeTabController.getOwner();
        return Text('Fetching owner info...');
      } else {
        bool chargingAvailable =
            ownerData["smartStaion"]["facilities"]["chargingAvailable"];
        String chargingPrice = chargingAvailable
            ? ownerData["smartStaion"]["facilities"]["chargingPrice"].toString()
            : "N/A";
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ${ownerData["name"]}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Card(
                color: ownerData["smartStaion"]["isAvailable"]
                    ? Colors.green
                    : Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Smart Station Details',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Name: ${ownerData["smartStaion"]["name"]}',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        chargingAvailable
                            ? 'Charging Price: $chargingPrice'
                            : 'Charging: Not Available',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Parking Price: ${ownerData["smartStaion"]["facilities"]["parkingPrice"]}',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Is Available: ${ownerData["smartStaion"]["isAvailable"]}',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
