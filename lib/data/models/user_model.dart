import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String firstName;
  String lastName;
  String location;
  String phone;
  var image;
  String? password;
  String? password_confirmation;
  String? fcm_token;
  int? id;
  String? role;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.location,
      required this.phone,
      required this.image,
      this.password,
      this.password_confirmation,
      this.id,
      this.role,
      this.fcm_token});

  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'location': location,
      'role': role,
      'phone': phone,
      'image': await MultipartFile.fromFile(image.path),
      'password': password,
      'password_confirmation': password_confirmation,
      'fcm_token': fcm_token
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      location: map['location'] as String,
      phone: map['phone'] as String,
      image: map['image'],
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
