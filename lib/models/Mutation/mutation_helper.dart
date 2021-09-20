import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_flutter_mbdimsum/basics/base_helper.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';
import 'package:new_flutter_mbdimsum/models/Mutation/mutation.dart';
import 'package:new_flutter_mbdimsum/models/cart_items/cart_items.dart';

class MutationHelper extends BaseHelper {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  String route = "Mutasi";

  Future<void> write(String itemID, Mutation mutation) async {
    await instance
        .collection(collectionPath)
        .doc(itemID)
        .collection("Mutasi")
        .doc(mutation.orderNumber)
        .set(mutation.toVariables());
  }

  Future<void> writeList(List<CartItems> cartItems, Cart cart) async {
    for (var e in cartItems) {
      var before = await getBefore(cart.orderNumber, e.itemID);
      Mutation mutation = Mutation(
        orderNumber: cart.id,
        quantity: e.quantity,
        stock: e.stock,
        dateTime: cart.dateTime,
        buySell: cart.buySell,
        total: e.price * e.quantity,
        customerName: cart.customer.name,
        before: before?.orderNumber ?? null,
        price: e.price,
      );
      write(e.itemID, mutation);
      if (before != null) setAfter(before, cart.orderNumber, e.itemID);
    }
  }

  Future<void> delete(String orderNumber, String itemID) async {
    await instance.collection(collectionPath).doc(orderNumber).delete();
  }

  Future<void> changeBeforeStock(
      String itemID, String before, int quantity) async {
    var result = await instance
        .collection(collectionPath)
        .doc(itemID)
        .collection("Mutasi")
        .get();
    var mutationBefore = await getBefore(before, itemID);

    var listResult =
        result.docs.map((e) => Mutation.fromMap(e.data())).toList();
    listResult.removeRange(
        0, listResult.indexWhere((e) => e == mutationBefore));
    for (var e in listResult) {
      await instance
          .collection(collectionPath)
          .doc(itemID)
          .collection("Mutasi")
          .doc(e.orderNumber)
          .update({"stock": FieldValue.increment(quantity)});
    }

    // await instance
    //     .collection(collectionPath)
    //     .doc(itemID)
    //     .collection("Mutasi")
    //     .doc(mutationBefore.orderNumber)
    //     .update({"stock": FieldValue.increment(quantity)});
  }

  Future<Mutation?> getBefore(String orderNumber, String itemID) async {
    var result = await instance
        .collection(collectionPath)
        .doc(itemID)
        .collection("Mutasi")
        .get();

    Mutation? before;
    try {
      before = Mutation.fromMap(result.docs.last.data());
    } catch (e) {
      before = null;
    }

    return before;
  }

  void setAfter(Mutation before, String orderNumber, String itemID) {
    before.after = orderNumber;
    write(itemID, before);
  }

  Mutation mapItem(Map<String, dynamic> map) {
    return Mutation.fromMap(map);
  }

  Future<Iterable<Mutation>> listFuture(String productID) async {
    var result = await instance
        .collection(collectionPath)
        .doc(productID)
        .collection("Mutasi")
        .get();

    if (result.docs.isEmpty) return [];
    return result.docs.map((e) => Mutation.fromMap(e.data()));
  }
}
