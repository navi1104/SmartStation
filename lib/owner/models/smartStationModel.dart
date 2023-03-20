import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_station/owner/models/facilitiesModel.dart';

class SmartStation {
  final String name;
  final String ownerId;
  final GeoPoint location;
  final String address;
  final bool isAvailable;
  final Facilities facilities;

  SmartStation({
    required this.name,
    required this.ownerId,
    required this.location,
    
    required this.address,
    required this.isAvailable,
    required this.facilities,
  });

  factory SmartStation.fromJson(Map<String, dynamic> json) {
    return SmartStation(
      name: json['name'],
      ownerId: json['ownerId'],
      
      location: json['location'],
      address: json['address'],
      isAvailable: json['isAvailable'],
      facilities: Facilities.fromJson(json['facilities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ownerId': ownerId,
      'location': location,
      'address': address,
      
      'isAvailable': isAvailable,
      'facilities': facilities.toJson(),
    };
  }
}
