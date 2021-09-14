class Customer {
  final String name;
  final String id;
  // final List history;
  // final List buy;

  Customer({required this.id, required this.name});

  static Customer fromMap(Map<String, dynamic> data) {
    return Customer(
      id: data['id'] ?? "",
      name: data['name'] ?? "",
    );
  }

  Map<String, dynamic> toVariables() {
    return {
      "id": id,
      "name": name,
    };
  }

  static List<Customer> fromMapList(List<Map<String, dynamic>> data) {
    return data.map((x) => fromMap(x)).toList();
  }
}
