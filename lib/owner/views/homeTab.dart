import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/homeTabController.dart';
import '../controllers/oAuthController.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  OwnerAuthController ownerAuthController = Get.find();

  HomeTabController homeTabController = Get.find();
  TextEditingController parkpriceController = TextEditingController();
  TextEditingController chargePriceController = TextEditingController();
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
        // ownerData['smartStation'][] = true;

        bool chargingAvailable =
            ownerData["smartStation"]["facilities"]["chargingAvailable"];
        print(chargingAvailable);
        String chargingPrice = chargingAvailable
            ? ownerData["smartStation"]["facilities"]["chargingPrice"]
                .toString()
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
              GestureDetector(
                onLongPress: () {
                  setState(() {
                    homeTabController.updateSmartStationAvailability();
                  });
                },
                child: Card(
                  color: ownerData["smartStation"]["isAvailable"]
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
                          'Name: ${ownerData["smartStation"]["name"]}',
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
                          'Parking Price: ${ownerData["smartStation"]["facilities"]["parkingPrice"]}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Is Available: ${ownerData["smartStation"]["isAvailable"]}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: '',
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: parkpriceController,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            labelText: 'New Parking price',
                                            hintMaxLines: 1,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 4.0))),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            homeTabController
                                                .updateParkingPrice(
                                                    double.parse(
                                                        parkpriceController
                                                            .text));
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'UPDATE PRICE',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      )
                                    ],
                                  ),
                                  radius: 10.0);
                            },
                            child: Text("Update Parking Price")),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                homeTabController.updateChargingSatus();
                              });
                            },
                            child: Text("Toggle Charger availability")),
                        ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: '',
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: chargePriceController,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            labelText: 'New Charging price',
                                            hintMaxLines: 1,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 4.0))),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            homeTabController
                                                .updateChargingPrice(
                                                    double.parse(
                                                        chargePriceController
                                                            .text));
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'UPDATE PRICE',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      )
                                    ],
                                  ),
                                  radius: 10.0);
                            },
                            child: Text("Update Charging price")),
                      ],
                    ),
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
