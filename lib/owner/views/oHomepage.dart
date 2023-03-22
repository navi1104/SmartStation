import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_station/owner/controllers/homeTabController.dart';
import 'package:smart_station/owner/controllers/oAuthController.dart';

import 'homeTab.dart';

OwnerAuthController _ownerAuthController = Get.find();

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({Key? key}) : super(key: key);

  @override
  _OwnerHomePageState createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    RequestsTab(),
    PaymentsReceivedTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Owner App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign out'),
              onTap: () {
                _ownerAuthController.signOut();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_quote),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class RequestsTab extends StatelessWidget {
  const RequestsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Requests Tab',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}

class PaymentsReceivedTab extends StatelessWidget {
  const PaymentsReceivedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Payments Received Tab',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
