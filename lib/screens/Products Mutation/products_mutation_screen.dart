import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/products.dart';
import 'package:new_flutter_mbdimsum/screens/Products%20Mutation/products_mutation_page.dart';
import 'package:new_flutter_mbdimsum/screens/base_screen.dart';

class ProductMutationScreen extends BaseScreens {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Products products;

  ProductMutationScreen({this.products});

  Widget content(context) {
    return ProductMutationPage(
      products: products,
    );
  }
}
