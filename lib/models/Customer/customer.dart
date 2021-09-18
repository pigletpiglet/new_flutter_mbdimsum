import 'dart:math';

class Customer {
  String name;
  String address;
  String id;
  // final List history;
  // final List buy;

  Customer({required this.address, required this.id, required this.name});

  static Customer empty() {
    return Customer(address: "", id: "", name: "");
  }

  static Customer fromMap(Map<String, dynamic> data) {
    return Customer(
      id: data['id'] ?? "",
      address: data['address'] ?? "",
      name: data['name'] ?? "",
    );
  }

  Map<String, dynamic> toVariables() {
    return {
      "id": id,
      "name": name,
      "address": address,
    };
  }

  static List<Customer> fromMapList(List<Map<String, dynamic>> data) {
    return data.map((x) => fromMap(x)).toList();
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
