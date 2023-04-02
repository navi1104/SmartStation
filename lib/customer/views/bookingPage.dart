import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_station/customer/controllers/requestController.dart';

class BookingPage extends StatefulWidget {
  String id;
  BookingPage({required this.id});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String dropdownValue = "Select";
  String bookStatus = "BOOK";
  RequestController _requestController = Get.find();
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
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Select', 'parking', 'charging']
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
                  _requestController.sendRequest(widget.id, selectedService);
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
