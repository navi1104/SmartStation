import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:smart_station/owner/models/facilitiesModel.dart';
import 'package:smart_station/owner/views/oLoginScreen.dart';

import '../controllers/oAuthController.dart';

class OwnerRegistrationForm extends StatefulWidget {
  @override
  State<OwnerRegistrationForm> createState() => _OwnerRegistrationFormState();
}

class _OwnerRegistrationFormState extends State<OwnerRegistrationForm> {
  final OwnerAuthController _authController = Get.find();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _upiIdController = TextEditingController();

  final TextEditingController _stationNameController = TextEditingController();

  final TextEditingController _latitudeController = TextEditingController();

  final TextEditingController _longitudeController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _parkingPriceController = TextEditingController();

  final TextEditingController _chargingPriceController =
      TextEditingController();

  final RxBool _isChargingAvailable = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owner Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: _upiIdController,
                decoration: InputDecoration(
                  labelText: 'UPI ID',
                ),
              ),
              TextFormField(
                controller: _stationNameController,
                decoration: InputDecoration(
                  labelText: 'Smart Station Name',
                ),
              ),
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                ),
              ),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                ),
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
              ),
              TextFormField(
                controller: _parkingPriceController,
                decoration: InputDecoration(
                  labelText: 'Parking Price (Rs./hr)',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Obx(
                () => CheckboxListTile(
                  title: Text('Charging Available'),
                  value: _isChargingAvailable.value,
                  onChanged: (value) {
                    setState(() {
                      _isChargingAvailable.value = value ?? false;
                    });

                    print(_isChargingAvailable.value);
                  },
                ),
              ),
              Container(
                  child: _isChargingAvailable.value
                      ? TextFormField(
                          controller: _chargingPriceController,
                          decoration: InputDecoration(
                            labelText: 'Charging Price (Rs./hr)',
                          ))
                      : SizedBox(
                          height: 0,
                        )),
              ElevatedButton(
                onPressed: () async {
                  LocationPermission permission;
                  permission = await Geolocator.requestPermission();
                  await _getLocation();
                  _getAddress();
                },
                child: Text('Get Location'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  LocationPermission permission;
                  permission = await Geolocator.requestPermission();
                  _registerOwner();
                },
                child: Text('Register'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => OwnerLoginScreen());
                  },
                  child: Text("Already have an account? Login"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getLocation() async {
    // code to get location goes here
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
      _latitudeController.text = position.latitude.toString();
      _longitudeController.text = position.longitude.toString();
    } catch (e) {
      Get.snackbar("Error", e.toString() + " enter location manually please");
      print(e);
    }
  }

  Future<void> _getAddress() async {
    // code to get location goes here
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          double.parse(_latitudeController.text),
          double.parse(_longitudeController.text));
      _locationController.text =
          "${placemarks[0].subLocality}, ${placemarks[0].locality}-${placemarks[0].postalCode}";
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }

  Future<void> _registerOwner() async {
    if (_nameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _upiIdController.text.isEmpty ||
        _stationNameController.text.isEmpty ||
        _latitudeController.text.isEmpty ||
        _longitudeController.text.isEmpty ||
        _parkingPriceController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    } else {
      Facilities facilities = Facilities(
          chargingAvailable: _isChargingAvailable.value,
          parkingPrice: double.parse(_parkingPriceController.text),
          chargingPrice: _isChargingAvailable.value
              ? double.parse(_chargingPriceController.text)
              : 0);

      _authController.signUp(
          _nameController.text,
          "+91${_phoneNumberController.text}",
          GeoPoint( double.parse(_latitudeController.text),
          double.parse(_longitudeController.text)),
         
          facilities,
          _stationNameController.text,
          _upiIdController.text,
          _locationController.text);
    }
  }
}
