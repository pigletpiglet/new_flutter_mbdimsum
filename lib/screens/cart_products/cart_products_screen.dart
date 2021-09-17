import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Cart%20Items/cart_items.dart';
import 'package:new_flutter_mbdimsum/screens/cart_products/cart_products_page.dart';
import 'package:new_flutter_mbdimsum/basics/base_screen.dart';

class CartProductsScreen extends BaseScreens {
  final CartItems cartItems;
  final bool buysell;
  CartProductsScreen({required this.cartItems, required this.buysell});

  @override
  Widget content(context) {
    return CartProductsPage(
      item: cartItems,
      buysell: buysell,
    );
  }
}
