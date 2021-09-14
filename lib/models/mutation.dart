import 'dart:math';

import 'package:new_flutter_mbdimsum/functions/date_parser.dart';
import 'package:new_flutter_mbdimsum/models/cart_items.dart';
import 'package:intl/intl.dart';

class Mutation {
  String orderNumber;
  String customerName;
  String timeStampString;
  String dateString;
  DateTime datetime;
  int quantity;
  int total;
  int price;
  int stock;
  bool buysell;

  Mutation({
    required this.orderNumber,
    required this.quantity,
    required this.stock,
    required this.datetime,
    required this.buysell,
    required this.total,
    required this.customerName,
    required this.price,
  })  : timeStampString = DateFormat("HH:mm").format(datetime),
        dateString = DateParser.parseDate(datetime);

  static Mutation fromMap(Map<String, dynamic> data) {
    return Mutation(
      orderNumber: data['ordernumber'] ?? "",
      datetime: DateTime.tryParse(data["datetime"]) ?? DateTime.now(),
      quantity: data['quantity'] ?? 0,
      total: data['total'] ?? 0,
      buysell: data['buysell'] ?? false,
      customerName: data['customername'] ?? "",
      price: data['price'] ?? 0,
      stock: data['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toVariables() {
    return {
      "ordernumber": orderNumber,
      "datetime": datetime.toIso8601String(),
      "quantity": quantity,
      "buysell": buysell,
      "total": total,
      "customername": customerName,
      "price": price,
      "stock": stock,
    };
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static List<Mutation> fromMapList(List<Map<String, dynamic>> data) {
    return data.map((x) => fromMap(x)).toList();
  }
}
