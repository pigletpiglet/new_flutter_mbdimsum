import 'package:new_flutter_mbdimsum/basics/base_helper.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer.dart';

class CustomerHelper extends BaseHelper {
  @override
  String route = "Customers";

  Future<void> write(Customer customer) async {
    await instance
        .collection(collectionPath)
        .doc(customer.id)
        .set(customer.toVariables());
  }

  Customer mapItem(Map<String, dynamic> map) {
    return Customer.fromMap(map);
  }

  Future<Iterable<Customer>> listFuture() async {
    var result = await instance.collection(collectionPath).get();

    if (result.docs.isEmpty) return [];
    return result.docs.map((e) => Customer.fromMap(e.data()));
  }

  void sort(List<Customer> list) {
    list.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
  }
}
