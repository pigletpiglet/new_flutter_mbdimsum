import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/cart.dart';
import 'package:new_flutter_mbdimsum/screens/base_screen.dart';
import 'package:new_flutter_mbdimsum/screens/Order%20Products/order_products_page.dart';

class OrderProductsScreen extends BaseScreens {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Cart cart;
  OrderProductsScreen({
    required this.cart,
  });

  @override
  Widget content(context) {
    return OrderProductsPage(
      cart: cart,
    );
  }
}
