import 'dart:math';

class CartItems {
  String itemName;
  String itemID;
  int price;
  int quantity;
  int stock;

  CartItems({
    required this.itemName,
    required this.itemID,
    required this.price,
    required this.quantity,
    required this.stock,
  });
  static CartItems fromMap(Map<String, dynamic> data) {
    return CartItems(
      itemName: data['productname'] ?? "",
      price: data['price'] ?? 0,
      quantity: data['quantity'] ?? 0,
      itemID: data['productid'] ?? "",
      stock: data['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toVariables() {
    // productname = getRandomString(8);
    return {
      "productname": itemName,
      "price": price,
      "quantity": quantity,
      "productid": itemID,
      "stock": stock,
    };
  }

  static CartItems empty() {
    return CartItems(
      itemID: '',
      itemName: '',
      price: 0,
      quantity: 0,
      stock: 0,
    );
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static List<CartItems> fromMapList(List<dynamic>? data) {
    return data?.map((x) => fromMap(x)).toList() ?? [];
  }
}
