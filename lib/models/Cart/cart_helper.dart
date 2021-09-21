import 'package:new_flutter_mbdimsum/basics/base_helper.dart';
import 'package:new_flutter_mbdimsum/models/Mutation/mutation.dart';
import 'package:new_flutter_mbdimsum/models/Mutation/mutation_helper.dart';
import 'package:new_flutter_mbdimsum/models/Products/products_helper.dart';

import 'cart.dart';

class CartHelper extends BaseHelper {
  @override
  String route = "Orders";
  final ProductsHelper _productsHelper = ProductsHelper();
  final MutationHelper _mutationHelper = MutationHelper();

  Future<void> write(Cart cart) async {
    for (var e in cart.cartItems) {
      Mutation? before =
          await _mutationHelper.getBefore(cart.orderNumber, e.itemID);

      if (cart.buySell) {
        _productsHelper.changeStock(
            e.itemID, e.quantity - (e.prevQuantity ?? 0));
      } else {
        _productsHelper.changeStock(
            e.itemID, -(e.quantity - (e.prevQuantity ?? 0)));
      }
    }
    await instance
        .collection(collectionPath)
        .doc(cart.id)
        .set(cart.toVariables());
  }

  Future<void> update(Cart cart) async {
    for (var e in cart.cartItems) {
      Mutation? before =
          await _mutationHelper.getBefore(cart.orderNumber, e.itemID);

      if (cart.buySell) {
        _productsHelper.changeStock(
            e.itemID, e.quantity - (e.prevQuantity ?? 0));
        if (before != null) {
          _mutationHelper.changeBeforeStock(
              e.itemID, before.orderNumber, e.quantity - (e.prevQuantity ?? 0));
        }
      } else {
        _productsHelper.changeStock(
            e.itemID, -(e.quantity - (e.prevQuantity ?? 0)));
        if (before != null) {
          _mutationHelper.changeBeforeStock(e.itemID, before.orderNumber,
              e.quantity - -(e.prevQuantity ?? 0));
        }
      }
    }
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

  Future<Iterable<Cart>> listFuture() async {
    var result = await instance.collection(collectionPath).get();

    if (result.docs.isEmpty) return [];
    return result.docs.map((e) => Cart.fromMap(e.data()));
  }
}
