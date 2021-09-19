import 'package:new_flutter_mbdimsum/basics/base_helper.dart';
import 'package:new_flutter_mbdimsum/models/Products/products_helper.dart';

import 'cart.dart';

class CartHelper extends BaseHelper {
  @override
  String route = "Orders";
  final ProductsHelper _productsHelper = ProductsHelper();

  Future<void> write(Cart cart) async {
    await instance
        .collection(collectionPath)
        .doc(cart.id)
        .set(cart.toVariables());
    for (var element in cart.cartItems) {
      if (cart.buySell) {
        _productsHelper.changeStock(element.itemID, element.quantity);
      } else {
        _productsHelper.changeStock(element.itemID, -element.quantity);
      }
    }
  }

  Future<void> update(Cart cart) async {
    await instance
        .collection(collectionPath)
        .doc(cart.id)
        .update(cart.toVariables());

    for (var element in cart.cartItems) {
      if (cart.buySell) {
        _productsHelper.changeStock(element.itemID, element.quantity);
      } else {
        _productsHelper.changeStock(element.itemID, -element.quantity);
      }
    }
  }

  Future<Cart> read(String id) async {
    var result = await instance.collection(collectionPath).doc(id).get();

    return Cart.fromMap(result.data()!);
  }

  Future<void> delete(String id) async {
    await instance.collection(collectionPath).doc(id).delete();
  }

  Future<Iterable<Cart>> listFuture() async {
    var result = await instance.collection(collectionPath).get();

    if (result.docs.isEmpty) return [];
    return result.docs.map((e) => Cart.fromMap(e.data()));
  }
}
