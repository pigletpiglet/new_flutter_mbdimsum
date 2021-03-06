import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/screens/check_orders/check_orders_page.dart';
import 'package:new_flutter_mbdimsum/basics/base_screen.dart';

class CheckOrdersScreen extends BaseScreens {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget content(context) {
    return CheckOrdersPage();
  }
}
