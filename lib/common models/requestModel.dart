


import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String name;
  final String service;
  final bool isAccepted;
  final String id;

  Request({
    required this.name,
    required this.service,
    required this.isAccepted,
    required this.id
    });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      name: json['name'],
      service: json['service'],
      isAccepted: json['isAccepted'],
      id: json['id']
       );
  }

  factory Request.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Request(
      name: data['name'],
      service: data['service'],
      isAccepted: data['isAccepted'],
      id: data['id'],
    );
  }
  

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'service': service,
      'isAccepted': isAccepted,
      'id': id
    };
  }
}



