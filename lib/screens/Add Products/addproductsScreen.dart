import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/products.dart';
import 'package:new_flutter_mbdimsum/screens/Add%20Products/addproductsPage.dart';
import 'package:new_flutter_mbdimsum/screens/base_screen.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddProductsScreen extends BaseScreens {
  @override
  Widget content(BuildContext context) {
    return AddProductsPage();
  }
}
