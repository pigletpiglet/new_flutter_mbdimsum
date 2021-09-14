import 'dart:math';

import 'package:intl/intl.dart';
import 'package:new_flutter_mbdimsum/functions/date_parser.dart';
import 'package:new_flutter_mbdimsum/models/cart_items.dart';

class History {
  String orderNumber;
  String customerName;
  String dropPoint;
  String timeStampString;
  String dateString;
  DateTime dateTime;
  int totalPrice;
  List<CartItems> cartItems;
  bool buySell;

  History({
    required this.orderNumber,
    required this.customerName,
    required this.dropPoint,
    required this.dateTime,
    required this.totalPrice,
    required this.cartItems,
    required this.buySell,
  })  : timeStampString = DateFormat("HH:mm").format(dateTime),
        dateString = DateParser.parseDate(dateTime);

  static History fromMap(Map<String, dynamic> data) {
    return History(
      orderNumber: data['ordernumber'] ?? "",
      customerName: data['customername'] ?? "",
      dropPoint: data['droppoint'] ?? "",
      dateTime: DateTime.tryParse(data["datetime"]) ?? DateTime.now(),
      totalPrice: data['totalprice'] ?? 0,
      cartItems: data['orderlists'],
      buySell: data['buysell'] ?? false,
    );
  }

  Map<String, dynamic> toVariables() {
    return {
      "ordernumber": orderNumber,
      "customername": customerName,
      "droppoint": dropPoint,
      "datetime": dateTime.toIso8601String(),
      "totalprice": totalPrice,
      "buysell": buySell
    };
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  int getTotalPrice() {
    totalPrice = 0;
    for (var x in cartItems) {
      totalPrice += (x.price * x.quantity);
    }
    return totalPrice;
  }

  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static List<History> fromMapList(List<Map<String, dynamic>> data) {
    return data.map((x) => fromMap(x)).toList();
  }
}
