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
}
