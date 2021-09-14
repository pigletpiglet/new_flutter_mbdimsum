import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/customer.dart';
import 'package:new_flutter_mbdimsum/screens/Check%20Orders/checkordersPage.dart';
import 'package:new_flutter_mbdimsum/screens/base_screen.dart';
import 'package:new_flutter_mbdimsum/screens/Customers/customersScreen.dart';

class CheckOrdersScreen extends BaseScreens {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Widget content(context) {
    return CheckOrdersPage();
  }
}
