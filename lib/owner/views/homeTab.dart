import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText('Hello ${ownerData["name"]} !',
                            textStyle: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                            speed: Duration(milliseconds: 200)),
                      ],
                      isRepeatingAnimation: false,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            homeTabController.updateSmartStationAvailability();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: ownerData["smartStation"]["isAvailable"]
                                  ? Colors.lightGreen
                                  : Colors.red,
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 10.0)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  width: 280,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Smart Station Details',
                                      style: TextStyle(
                                          fontSize: 22.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  '   Name : ${ownerData["smartStation"]["name"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  chargingAvailable
                                      ? '   Charging Price : ₹ $chargingPrice /hr.'
                                      : '   Charging : Not Available',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '   Parking Price : ₹ ${ownerData["smartStation"]["facilities"]["parkingPrice"]} /hr.',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '   Is Available : ${ownerData["smartStation"]["isAvailable"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: SizedBox(
                      height: 70,
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
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
                                      height: 20.0,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 300,
                                      child: ElevatedButton(
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
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.0))),
                                      ),
                                    )
                                  ],
                                ),
                                radius: 10.0);
                          },
                          child: Text(
                            "Update Parking Price",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 11, 4, 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0))),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 70,
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              homeTabController.updateChargingSatus();
                            });
                          },
                          child: Text(
                            "Toggle Charger Availability",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 11, 4, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 70,
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
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
                                          labelText: 'New Charging Price',
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
                                          homeTabController.updateChargingPrice(
                                              double.parse(
                                                  chargePriceController.text));
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 300,
                                        child: Center(
                                          child: Text(
                                            'UPDATE PRICE',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.lightGreen,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0))),
                                    )
                                  ],
                                ),
                                radius: 10.0);
                          },
                          child: Text(
                            "Update Charging Price",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 11, 4, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
