import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart_helper.dart';
import 'package:new_flutter_mbdimsum/screens/Cart/cart_screen.dart';

class OrderList extends StatelessWidget {
  final currencyFormat = NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp",
  );
  Cart? cart;
  MaterialColor? sendColor, payColor;
  CartHelper cartHelper = CartHelper();
  OrderList({this.cart, this.sendColor, this.payColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return CartScreen(
                cart: cart,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Customers",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          cart?.customer.name ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Builder(
                    builder: (context) {
                      if (cart?.buySell ?? false)
                        return const Text("Beli");
                      else
                        return const Text("Jual");
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        cart?.dateString ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: sendColor,
                      size: 30,
                    ),
                    onPressed: () async {
                      var value = await showDialog<bool>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Apakah sudah dikirim'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Pastikan Barang sudah dikirim'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Sudah'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text("Batal"),
                              )
                            ],
                          );
                        },
                      );
                      // await cartHelper.setOrder(
                      //   "hassend",
                      //   cart?.orderNumber ?? "",
                      //   value,
                      // );
                      // return value;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.payment,
                      color: payColor,
                      size: 30,
                    ),
                    onPressed: () async {
                      var value = await showDialog<bool>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Apakah sudah dibayar'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Pastikan Barang sudah dibayar'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Sudah'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text("Batal"),
                              )
                            ],
                          );
                        },
                      );
                      // await cartHelper.setOrder(
                      //   "haspay",
                      //   cart.orderNumber,
                      //   value,
                      // );
                      // return value;
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Price"),
                      Text(currencyFormat.format(cart?.totalPrice ?? 0)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
