import 'dart:ui';

import 'package:flutter/material.dart';

class PaymentsReceivedTab extends StatefulWidget {
  const PaymentsReceivedTab({Key? key}) : super(key: key);

  @override
  State<PaymentsReceivedTab> createState() => _PaymentsReceivedTabState();
}

class _PaymentsReceivedTabState extends State<PaymentsReceivedTab> {
  List<Map> products = [
    {"id": "₹ 500", "name": "NAVANIT KRISH K M", "service": "parking"},
    {"id": "₹ 1000", "name": "BHARANIDHARAN", "service": "parking"},
    {"id": "₹ 300", "name": "HARISH", "service": "parking"},
    {"id": "₹ 600", "name": "JEEVAN", "service": "charging"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(color: Colors.grey),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 5)]),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      trailing: Text(
                        products[index]["id"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        products[index]["name"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
