import 'dart:math';

import 'package:intl/intl.dart';
import 'package:new_flutter_mbdimsum/functions/date_parser.dart';
import 'package:new_flutter_mbdimsum/models/Cart%20Items/cart_items.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer.dart';

class Cart {
  Customer customer;
  late String id;
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
        dateString = DateParser.parseDate(dateTime),
        id = getID(orderNumber, dateTime);

  static Cart fromMap(Map<String, dynamic> data) {
    return Cart(
      orderNumber: data['ordernumber'] ?? "",
      customer: Customer.fromMap(data['customer']),
      cartItems: CartItems.fromMapList(data['cartItems'] ?? []),
      dropPoint: data['droppoint'] ?? "",
      dateTime: DateTime.tryParse(data["datetime"]) ?? DateTime.now(),
      totalPrice: data['totalprice'] ?? 0,
      hasSend: data['hassend'] ?? false,
      hasPay: data['haspay'] ?? false,
      buySell: data['buysell'] ?? false,
    );
  }

  bool isEmpty() {
    return this == Cart.empty();
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
      "id": id,
      "ordernumber": orderNumber,
      "customer": customer.toVariables(),
      "droppoint": dropPoint,
      "datetime": dateTime.toIso8601String(),
      "totalprice": totalPrice,
      "cartitems": cartItems.map((e) => e.toVariables()),
      "hassend": hasSend,
      "haspay": hasPay,
      "buysell": buySell
    };
  }

  static String getID(String str, DateTime time) {
    return time.day.toString() +
        time.month.toString() +
        time.year.toString() +
        time.hour.toString() +
        time.minute.toString() +
        time.second.toString() +
        str;
  }

  int getTotalPrice() {
    totalPrice = 0;
    for (var x in cartItems) {
      totalPrice += (x.price * x.quantity);
    }
    return totalPrice;
  }

  static List<Cart> fromMapList(List<Map<String, dynamic>> data) {
    return data.map((x) => fromMap(x)).toList();
  }
}
