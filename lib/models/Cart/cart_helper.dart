import 'package:new_flutter_mbdimsum/basics/base_helper.dart';

import 'cart.dart';

class CartHelper extends BaseHelper {
  @override
  String route = "Orders";

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
