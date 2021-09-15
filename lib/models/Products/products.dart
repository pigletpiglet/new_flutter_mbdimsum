import 'dart:math';

class Products {
  String productId;
  String name;
  int stock, price;
  // List transactions;

  Products({
    required this.productId,
    required this.name,
    required this.stock,
    required this.price,
    // this.transactions,
  });

  static Products empty() {
    return Products(
      name: '',
      price: 0,
      productId: '',
      stock: 0,
    );
  }

  static Products fromMap(Map<String, dynamic> data) {
    return Products(
      productId: data['productid'] ?? "",
      name: data['name'] ?? "",
      stock: data['stock'] ?? 0,
      price: data['price'] ?? 0,
    );
  }

  Map<String, dynamic> toVariables() {
    return {
      "productid": productId,
      "name": name,
      "stock": stock,
      "price": price,
    };
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static List<Products> fromMapList(List<Map<String, dynamic>> data) {
    return data.map((x) => fromMap(x)).toList();
  }
}
