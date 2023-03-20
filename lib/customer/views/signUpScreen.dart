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
          backgroundColor: Colors.orange,
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: ListView(children: [
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Name',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                        (states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Colors.orange;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Phone Number',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                        (states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Colors.orange;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _vehicleNameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Vehicle Name',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                        (states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Colors.orange;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _licensePlateController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'License Plate',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                        (states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Colors.orange;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your license plate number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _vehicleTypeController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Vehicle Type',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                        (states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Colors.orange;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your vehicle type';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _vehicleSubTypeController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Vehicle Sub-Type',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                        (states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Colors.orange;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                    ),
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
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
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
