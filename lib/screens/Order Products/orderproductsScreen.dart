import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/customer.dart';
import 'package:new_flutter_mbdimsum/models/orders.dart';
import 'package:new_flutter_mbdimsum/screens/base_screen.dart';
import 'package:new_flutter_mbdimsum/screens/Customers/customersScreen.dart';
import 'package:new_flutter_mbdimsum/screens/Order%20Products/orderproductsPage.dart';

class OrderProductsScreen extends BaseScreens {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Order order;
  OrderProductsScreen({
    this.order,
  });

  Widget content(context) {
    return OrderProductsPage(
      order: order,
    );
  }
}
