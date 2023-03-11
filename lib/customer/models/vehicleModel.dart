class Vehicle {
  final String vehicleName;
  final String licensePlate;
  final String vehicleType;
  final String vehicleSubType;

  Vehicle({
    required this.vehicleName,
    required this.licensePlate,
    required this.vehicleType,
    required this.vehicleSubType,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleName: json['vehicleName'],
      licensePlate: json['licensePlate'],
      vehicleType: json['vehicleType'],
      vehicleSubType: json['vehicleSubType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleName': vehicleName,
      'licensePlate': licensePlate,
      'vehicleType': vehicleType,
      'vehicleSubType': vehicleSubType,
    };
  }
}
