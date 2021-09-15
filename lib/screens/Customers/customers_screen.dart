import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/basics/base_screen.dart';
import 'package:new_flutter_mbdimsum/screens/Customers/customers_page.dart';

class CustomersScreen extends BaseScreens {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget content(context) {
    return CustomersPage();
  }
}
