import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/controllers/requestController.dart';

class BookingPage extends StatefulWidget {
  String? id;
  BookingPage(friend, {this.id});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

RequestController _requestController = Get.find();
String dropdownValue = "Select";
String bookStatus = "BOOK";

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "Please Select the service",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //try{}catch(e){}
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['parking', 'charging']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  String selectedService = dropdownValue;

                  await _requestController.sendRequest(
                      widget.id!, selectedService);
                  setState(() {
                    bookStatus = "requested";
                  });
                },
                child: Text(bookStatus)),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    bookStatus = "BOOK";
                  });
                  Navigator.pop(context);
                },
                child: Text("Cancel"))
          ],
        ),
      ),
    );
  }
}
