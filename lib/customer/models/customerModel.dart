
import 'package:smart_station/customer/models/vehicleModel.dart';

class Customer {
  final String name;
  final String phoneNumber;
  final Vehicle vehicle;

  Customer({
    required this.name,
    required this.phoneNumber,
    required this.vehicle,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      vehicle: Vehicle.fromJson(json['vehicle']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'vehicle': vehicle.toJson(),
    };
  }
}

