import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool mapToggle = false;
  bool friendsToogle = false;
  double distance = 0.0;
  Position? currentLocation;

  var friends = [];

  Set<Marker> _markers = {};

  late GoogleMapController mapController;

  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    final LocationPermission permission = await geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await geolocator.requestPermission();
    }

    final Position? position = await geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        currentLocation = position;
        mapToggle = true;
        friendsLocation();
      });
    }
  }

  friendsLocation() async {
    friends = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('owners').get();
    if (snapshot.docs.isNotEmpty) {
      setState(() {
        friendsToogle = true;
      });
      for (int i = 0; i < snapshot.docs.length; i++) {
        friends.add(snapshot.docs[i].data());
        initMarker(snapshot.docs[i].data());
        print(friends);
      }
    }
  }

  initMarker(friends) async {
    LatLng position = LatLng(
      friends['smartStation']['location'].latitude,
      friends['smartStation']['location'].longitude,
    );

    double distanceInMeters = await Geolocator.distanceBetween(
      currentLocation!.latitude,
      currentLocation!.longitude,
      friends['smartStation']['location'].latitude,
      friends['smartStation']['location'].longitude,
    );
    double distanceInKm = distanceInMeters / 1000;
    double roundedDistance = double.parse(distanceInKm.toStringAsFixed(2));
    distance = roundedDistance;

    _markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        draggable: false,
        // infoWindow: InfoWindow(
        //   title: friends['locName'],
        //   snippet: 'Tap to Navigate',
        //   onTap: () async {
        //     final url = 'https://www.google.com/maps/dir/?api=1&destination=' +
        //         friends['location'].latitude.toString() +
        //         ',' +
        //         friends['location'].longitude.toString();
        //     if (await canLaunch(url)) {
        //       await launch(url);
        //     } else {
        //       throw 'Could not launch $url';
        //     }
        //   },
        // ),
      ),
    );

    setState(() {});
  }

// void initMarker(friends) {
//   if (friends['location']?.latitude == null || friends['location']?.longitude == null) {
//   return;
// }

// LatLng position = LatLng(
//   friends['location']!.latitude,
//   friends['location']!.longitude,
// );

//   _markers.add(
//     Marker(
//       markerId: MarkerId(position.toString()),
//       position: position,
//       draggable: false,
//     ),
//   );

//   _markers = Set.of(_markers);
// }

  Widget friendsCard(Map<String, dynamic> friends) {
    double distanceInMeters = Geolocator.distanceBetween(
      currentLocation!.latitude,
      currentLocation!.longitude,
      friends['smartStation']['location'].latitude,
      friends['smartStation']['location'].longitude,
    );
    double distanceInKm = distanceInMeters / 1000;

    return Padding(
      padding: EdgeInsets.only(left: 2.0, bottom: 0.0, top: 0.0, right: 5.0),
      child: InkWell(
        onTap: () {
          zoomInMarker(friends);
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.9),
                spreadRadius: 2.0,
                blurRadius: 10.0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width - 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${friends['smartStation']['name'].split(' ')[0]}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                //Text("${distanceInKm.toStringAsFixed(2)} km"),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${distanceInKm.toStringAsFixed(1)} km",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${friends['phoneNumber']}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                              //SizedBox(width: 50.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.ev_station,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 3.0,
                                  ),
                                  Text(
                                    "${friends['smartStation']['facilities']['chargingPrice']}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${friends['smartStation']['address'].replaceAll(new RegExp(r'\b\d{6}\b'), '').replaceAll(', Chennai', '').replaceAll(RegExp(r', Chennai \d{6}$|-'), '')}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              //  SizedBox(width: 50.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_parking,
                                    color: Colors.redAccent,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 3.0,
                                  ),
                                  Text(
                                    "${friends['smartStation']['facilities']['parkingPrice']}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              //_showBottomSheet(context);
                              launch(
                                  'https://www.google.com/maps/dir/?api=1&destination=${friends['smartStation']['location'].latitude},${friends['smartStation']['location'].longitude}&travelmode=driving');
                            },
                            child: Text('Book'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              //_showBottomSheet(context);
                              launch(
                                  'https://www.google.com/maps/dir/?api=1&destination=${friends['smartStation']['location'].latitude},${friends['smartStation']['location'].longitude}&travelmode=driving');
                            },
                            child: Text('Navigate Now'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  zoomInMarker(friends) {
    setState(() {
      _markers = _markers.map((marker) {
        if (marker.position.latitude ==
                friends['smartStation']['location'].latitude &&
            marker.position.longitude ==
                friends['smartStation']['location'].longitude) {
          return marker.copyWith(
            iconParam: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
          );
        } else {
          return marker.copyWith(
            iconParam: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          );
        }
      }).toSet();
    });

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        friends['smartStation']['location'].latitude,
        friends['smartStation']['location'].longitude,
      ),
      zoom: 14.0,
      bearing: 90.0,
      tilt: 45.0,
    )));
  }

  // void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.symmetric(horizontal: 20),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             SizedBox(height: 50),
  //             Text(
  //               'Bottom Sheet Title',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Text(
  //               'Bottom Sheet Message',
  //               style: TextStyle(
  //                 fontSize: 16,
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 // _showBottomSheet(context);
  //                 // launch(
  //                 //     'https://www.google.com/maps/dir/?api=1&destination=${friends['location']},${friends[1].longitude}&travelmode=driving');
  //               },
  //               child: Text('BOOK'),
  //             ),
  //             SizedBox(height: 20),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "List of Markers",
        //     style: TextStyle(fontSize: 28, color: Colors.white),
        //   ),
        // ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: mapToggle
                        ? GoogleMap(
                            zoomControlsEnabled: false,
                            markers: _markers,
                            mapType: MapType.normal,
                            onMapCreated: onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(currentLocation!.latitude,
                                  currentLocation!.longitude),
                              zoom: 20.0,
                            ))
                        : Center(
                            child: Text(
                              "Loading.. Please wait..",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height - 230,
                      left: 10.0,
                      right: 10.0,
                      bottom: MediaQuery.of(context).size.height - 850,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width - 50,
                        child: friendsToogle
                            ? ListView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(8.0),
                                children: friends.map((elements) {
                                  return Row(
                                    children: [
                                      friendsCard(elements),
                                      SizedBox(
                                          width: 10.0), // add some space here
                                    ],
                                  );
                                }).toList(),
                              )
                            : Container(
                                height: 1.0,
                                width: 1.0,
                              ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
