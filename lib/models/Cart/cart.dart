import 'dart:math';

import 'package:intl/intl.dart';
import 'package:new_flutter_mbdimsum/functions/date_parser.dart';
import 'package:new_flutter_mbdimsum/models/Cart%20Items/cart_items.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer.dart';

class Cart {
  Customer customer;
  String orderNumber;
  String dropPoint;
  String timeStampString;
  String dateString;
  DateTime dateTime;
  int totalPrice;
  List<CartItems> cartItems;
  bool hasSend;
  bool hasPay;
  bool buySell;

  Cart(
      {required this.orderNumber,
      required this.customer,
      required this.dropPoint,
      required this.dateTime,
      required this.totalPrice,
      required this.cartItems,
      required this.hasSend,
      required this.hasPay,
      required this.buySell})
      : timeStampString = DateFormat("HH:mm").format(dateTime),
        dateString = DateParser.parseDate(dateTime);

  static Cart fromMap(Map<String, dynamic> data) {
    return Cart(
      orderNumber: data['ordernumber'] ?? "",
      customer: data['customer'] ?? "",
      dropPoint: data['droppoint'] ?? "",
      dateTime: DateTime.tryParse(data["datetime"]) ?? DateTime.now(),
      totalPrice: data['totalprice'] ?? 0,
      hasSend: data['hassend'] ?? false,
      hasPay: data['haspay'] ?? false,
      cartItems: data['orderlists'],
      buySell: data['buysell'] ?? false,
    );
  }

  static Cart empty() {
    return Cart(
      buySell: false,
      cartItems: [],
      customer: Customer.empty(),
      dateTime: DateTime.now(),
      dropPoint: '',
      hasPay: false,
      hasSend: false,
      orderNumber: '',
      totalPrice: 0,
    );
  }

  Map<String, dynamic> toVariables() {
    return {
      "ordernumber": orderNumber,
      "customer": customer,
      "droppoint": dropPoint,
      "datetime": dateTime.toIso8601String(),
      "totalprice": totalPrice,
      "hassend": hasSend,
      "haspay": hasPay,
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

  static List<Cart> fromMapList(List<Map<String, dynamic>> data) {
    return data.map((x) => fromMap(x)).toList();
  }
}
