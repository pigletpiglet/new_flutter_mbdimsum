import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Products/products.dart';
import 'package:new_flutter_mbdimsum/screens/products_mutation/products_mutation_page.dart';
import 'package:new_flutter_mbdimsum/basics/base_screen.dart';

class ProductMutationScreen extends BaseScreens {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Products products;

  ProductMutationScreen({required this.products});

  @override
  Widget content(context) {
    return ProductMutationPage(
      products: products,
    );
  }
}
