import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/customer.dart';
import 'package:new_flutter_mbdimsum/screens/base_screen.dart';
import 'package:new_flutter_mbdimsum/screens/Customers/customersPage.dart';

class CustomersScreen extends BaseScreens {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Customer customer;

  Widget content(context) {
    return CustomersPage();
  }
}
