import 'package:smart_station/owner/models/smartStationModel.dart';

class Owner {
  final String name;
  final String phoneNumber;
  final SmartStation smartStation;
  final String upiId;

  Owner({
    required this.name,
    required this.phoneNumber,
    required this.smartStation,
    required this.upiId,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      smartStation: SmartStation.fromJson(json['smartStation']),
      upiId: json['upiId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'smartStation': smartStation.toJson(),
      'upiId': upiId,
    };
  }
}