import 'package:smart_station/owner/models/facilitiesModel.dart';

class SmartStation {
  final String name;
  final String ownerId;
  final String latitude;
  final String longitude;
  final String location;
  final bool isAvailable;
  final Facilities facilities;

  SmartStation({
    required this.name,
    required this.ownerId,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.isAvailable,
    required this.facilities,
  });

  factory SmartStation.fromJson(Map<String, dynamic> json) {
    return SmartStation(
      name: json['name'],
      ownerId: json['ownerId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],
      isAvailable: json['isAvailable'],
      facilities: Facilities.fromJson(json['facilities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ownerId': ownerId,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
      'isAvailable': isAvailable,
      'facilities': facilities.toJson(),
    };
  }
}
