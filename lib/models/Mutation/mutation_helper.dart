import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_flutter_mbdimsum/basics/base_helper.dart';
import 'package:new_flutter_mbdimsum/models/Mutation/mutation.dart';

class MutationHelper extends BaseHelper {
  late String? productID;
  MutationHelper({this.productID});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  String route = "Mutasi";

  String get fullCollectionName =>
      "Products" + (BaseHelper.production ? "_dev" : "");
  CollectionReference get collection =>
      firestore.collection(fullCollectionName).doc(productID).collection(route);

  Future<void> create(Mutation mutation) async {
    await collection.doc(mutation.orderNumber).set(mutation.toVariables());
  }

  Future<void> delete(String orderNumber) async {
    await collection.doc(orderNumber).delete();
  }

  Future<void> changeStock(String orderNumber, int quantity) async {
    await collection
        .doc(orderNumber)
        .update({"stock": FieldValue.increment(quantity)});
  }

  Mutation mapItem(Map<String, dynamic> map) {
    return Mutation.fromMap(map);
  }
}
