import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String ? id;
  String ? name;
  String ? address;
  int ? phonenumber;
  Timestamp ? establishedAt;
  List? services;
  Company(
    {
      this.id,
      this.address,
      this.name,
      this.phonenumber,
      this.establishedAt,
      this.services});
}