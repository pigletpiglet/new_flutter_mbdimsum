import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart.dart';

class CartHelper {
  final instance = FirebaseFirestore.instance;
  String collectionPath = "Orders";
  Future<void> write(Cart cart) async {
    await instance
        .collection(collectionPath)
        .doc(cart.id)
        .set(cart.toVariables());
  }

  Future<void> update(Cart cart) async {
    await instance
        .collection(collectionPath)
        .doc(cart.id)
        .update(cart.toVariables());
  }

  Future<Cart> read(String id) async {
    var result = await instance.collection(collectionPath).doc(id).get();

    return Cart.fromMap(result.data()!);
  }

  Future<void> delete(String id) async {
    await instance.collection(collectionPath).doc(id).delete();
  }
}
