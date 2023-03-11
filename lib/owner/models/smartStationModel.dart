import 'package:smart_station/owner/models/facilitiesModel.dart';

class SmartStation {
  final String name;
  final String location;
  final bool isAvailable;
  final Facilities facilities;

  SmartStation({
    required this.name,
    required this.location,
    required this.isAvailable,
    required this.facilities,
  });

  factory SmartStation.fromJson(Map<String, dynamic> json) {
    return SmartStation(
      name: json['name'],
      location: json['location'],
      isAvailable: json['isAvailable'],
      facilities: Facilities.fromJson(json['facilities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'isAvailable': isAvailable,
      'facilities': facilities.toJson(),
    };
  }
}