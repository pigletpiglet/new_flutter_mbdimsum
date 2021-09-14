import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/ordersproduct.dart';
import 'package:new_flutter_mbdimsum/models/products.dart';
import 'package:new_flutter_mbdimsum/screens/Cart%20Products/cartproductsPage.dart';
import 'package:new_flutter_mbdimsum/screens/base_screen.dart';

class CartProductsScreen extends BaseScreens {
  OrderProducts products;
  bool buysell;
  CartProductsScreen({this.products, this.buysell});
  Widget content(context) {
    return CartProductsPage(
      products: products,
      buysell: buysell,
    );
  }
}
