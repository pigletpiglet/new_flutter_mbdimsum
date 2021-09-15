import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';
import 'package:new_flutter_mbdimsum/basics/base_screen.dart';
import 'package:new_flutter_mbdimsum/screens/Cart/cart_page.dart';

class CartScreen extends BaseScreens {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Cart? cart;
  CartScreen({
    this.cart,
  });

  @override
  Widget content(context) {
    return CartPage(
      cart: cart,
    );
  }
}
