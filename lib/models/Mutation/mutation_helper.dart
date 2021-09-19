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
      write(
        e.itemID,
        Mutation(
          orderNumber: cart.id,
          quantity: e.quantity,
          stock: e.stock,
          dateTime: cart.dateTime,
          buySell: cart.buySell,
          total: e.price * e.quantity,
          customerName: cart.customer.name,
          price: e.price,
        ),
      );
    }
  }

  Future<void> delete(String orderNumber, String itemID) async {
    await instance.collection(collectionPath).doc(orderNumber).delete();
  }

  Future<void> changeStock(String orderNumber, int quantity) async {
    await instance
        .collection(collectionPath)
        .doc(orderNumber)
        .update({"stock": FieldValue.increment(quantity)});
  }

  Mutation mapItem(Map<String, dynamic> map) {
    return Mutation.fromMap(map);
  }
}
