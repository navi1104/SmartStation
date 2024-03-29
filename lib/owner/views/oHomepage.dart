import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_station/owner/controllers/homeTabController.dart';
import 'package:smart_station/owner/controllers/oAuthController.dart';
import 'package:get/get.dart';
import 'homeTab.dart';
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'orequestpage.dart';
import 'oPaymentspage.dart';

OwnerAuthController _ownerAuthController = Get.find();
void hello() {
  Get.put(HomeTabController());
}

class OwnerHomePage extends StatefulWidget {
  OwnerHomePage({Key? key}) : super(key: key);

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
      Get.put(HomeTabController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Home'),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 120,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  'Owner App',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'Sign out',
                style: TextStyle(fontSize: 20),
              ),
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.lightGreen,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.lightGreen,
            icon: Icon(Icons.request_quote),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.lightGreen,
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

/*class RequestsTab extends StatefulWidget {
  RequestsTab({Key? key}) : super(key: key);

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  List<Map> products = [
    {
      "id": "01",
      "name": "dnyaneshwar wakshe ",
      "class": "SYMCA",
      "college": "VIT , Pune"
    },
    {
      "id": "02",
      "name": "Aarush Babbar",
      "class": "SYMCA",
      "college": "VIT , Pune"
    },
    {
      "id": "03",
      "name": "Abrar Alsam",
      "class": "SYMCA",
      "college": "VIT , Pune"
    },
    {
      "id": "04",
      "name": "Satyam Chaurasiya",
      "class": "SYMCA",
      "college": "VIT , Pune"
    },
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
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 5)]),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      trailing: Text(products[index]["id"]),
                      title: Text(products[index]["name"]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                            Get.defaultDialog(
                                title: '',
                                content: Column(
                                  children: [
                                    StreamBuilder<int>(
                                        stream: _stopWatchTimer.rawTime,
                                        initialData:
                                            _stopWatchTimer.rawTime.value,
                                        builder: (context, snapshot) {
                                          final value = snapshot.data;
                                          final displayTime =
                                              StopWatchTimer.getDisplayTime(
                                                  value!,
                                                  hours: _isHours);
                                          return Text(
                                            displayTime,
                                            style: const TextStyle(
                                                fontSize: 40.0,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text("End"),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0))),
                                    )
                                  ],
                                ));
                          },
                          child: Text('Accept'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              products.removeAt(index);
                            });
                          },
                          child: Text('Reject'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}*/

/*class PaymentsReceivedTab extends StatelessWidget {
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
}*/
