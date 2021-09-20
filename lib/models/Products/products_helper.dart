import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_flutter_mbdimsum/basics/base_helper.dart';
import 'package:new_flutter_mbdimsum/models/Mutation/mutation_helper.dart';

import 'products.dart';

class ProductsHelper extends BaseHelper {
  @override
  String route = "Products";

  Future<void> write(Products products) async {
    await instance
        .collection(collectionPath)
        .doc(products.productId)
        .set(products.toVariables());
  }

  Future<void> changeStock(String productsID, int quantity) async {
    await instance
        .collection(collectionPath)
        .doc(productsID)
        .update({"stock": FieldValue.increment(quantity)});
  }

  Future<void> update(Products products) async {
    await instance
        .collection(collectionPath)
        .doc(products.productId)
        .update(products.toVariables());
  }

  Future<Iterable<Products>> listFuture() async {
    var result = await instance.collection(collectionPath).get();

    if (result.docs.isEmpty) return [];
    return result.docs.map((e) => Products.fromMap(e.data()));
  }

  Future<Products> read(String id) async {
    var result = await instance.collection(collectionPath).doc(id).get();

    return Products.fromMap(result.data()!);
  }

  Future<void> delete(String id) async {
    await instance.collection(collectionPath).doc(id).delete();
  }
}
