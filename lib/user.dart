import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name;
  final String? email;
  final String? number;
  final String? guardianname;
  final String? relationship;

  UserModel({
    this.name,
    this.email,
    this.guardianname,
    this.number,
    this.relationship,
  });

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      // Handle the case where the map is null
      return UserModel(
        name: '',
        email: '',
        number: '',
        relationship: '',
        guardianname: '',
      );
    }

    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      number: map['number'] ?? '',
      relationship: map['relationship'] ?? '',
      guardianname: map['guardianname'] ?? '',
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return UserModel(
      name: data?['name'] ?? '',
      email: data?['email'] ?? '',
      relationship: data?['relationship'] ?? '',
      guardianname: data?['guardianname'] ?? '',
      number: data?['number'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'email': email,
        'number': number,
        'relationship': relationship,
        'guardianname': guardianname,
      
      };
}

class StatusModel {
  final String? age;
  final String? sex;
  final String? presentStatus;
  final String? previousStatus;

  const StatusModel({
    this.age,
    this.presentStatus,
    this.previousStatus,
    this.sex,
  });

  Map<String, dynamic> toFirestore() => {
        'age': age,
        'presentStatus': presentStatus,
        'previousStatus': previousStatus,
        'sex': sex,
      };
}
