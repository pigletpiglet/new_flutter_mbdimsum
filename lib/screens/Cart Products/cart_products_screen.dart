import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/cart_items.dart';
import 'package:new_flutter_mbdimsum/screens/Cart%20Products/cart_products_page.dart';
import 'package:new_flutter_mbdimsum/screens/base_screen.dart';

class CartProductsScreen extends BaseScreens {
  final CartItems cartItems;
  final bool buysell;
  CartProductsScreen({required this.cartItems, required this.buysell});

  @override
  Widget content(context) {
    return CartProductsPage(
      products: cartItems,
      buysell: buysell,
    );
  }
}
