import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/views/loginScreen.dart';

import '../controllers/custAuthController.dart';
import '../models/vehicleModel.dart';

class CustomerSignupScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _vehicleNameController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _vehicleSubTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customer Signup'),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: ListView(children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _vehicleNameController,
                    decoration: InputDecoration(labelText: 'Vehicle Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _licensePlateController,
                    decoration: InputDecoration(labelText: 'License Plate'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your license plate number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _vehicleTypeController,
                    decoration: InputDecoration(labelText: 'Vehicle Type'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle type';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _vehicleSubTypeController,
                    decoration: InputDecoration(labelText: 'Vehicle Sub-Type'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle sub-type';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final vehicle = Vehicle(
                          vehicleName: _vehicleNameController.text,
                          licensePlate: _licensePlateController.text,
                          vehicleType: _vehicleTypeController.text,
                          vehicleSubType: _vehicleSubTypeController.text,
                        );

                        final name = _nameController.text;
                        final phoneNumber = "+91${_phoneNumberController.text}";

                        _authController.signUp(
                          name,
                          phoneNumber,
                          vehicle,
                        );
                      }
                    },
                    child: Text('Sign Up'),
                  ),
                  SizedBox(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Already have an account? "),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Text(
                          'Login',
                        ))
                  ])
                ]))));
  }
}
