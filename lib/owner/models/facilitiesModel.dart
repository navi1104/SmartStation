
class Facilities {
  final bool chargingAvailable;
  final double chargingPrice;
  final double parkingPrice;

  Facilities({
    required this.chargingAvailable,
    this.chargingPrice = 0,
    required this.parkingPrice,
  });

  factory Facilities.fromJson(Map<String, dynamic> json) {
    return Facilities(
      chargingAvailable: json['chargingAvailable'],
      chargingPrice: json['chargingPrice'],
      parkingPrice: json['parkingPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chargingAvailable': chargingAvailable,
      'chargingPrice': chargingPrice,
      'parkingPrice': parkingPrice,
    };
  }
}
