import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart_helper.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer.dart';
import 'package:new_flutter_mbdimsum/models/History/history.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';
import 'package:new_flutter_mbdimsum/models/Cart%20Items/cart_items.dart';
import 'package:new_flutter_mbdimsum/extensions/cart_extensions.dart';
import 'package:new_flutter_mbdimsum/models/History/history_helper.dart';

import 'package:new_flutter_mbdimsum/screens/Cart/cart_screen.dart';

class CheckOrdersPage extends StatefulWidget {
  @override
  _CheckOrdersPageState createState() => _CheckOrdersPageState();
}

class _CheckOrdersPageState extends State<CheckOrdersPage> {
  late List<Cart> carts;

  late CartHelper _cartHelper;
  late HistoryHelper _historyHelper;

  @override
  void initState() {
    _cartHelper = CartHelper();
    _historyHelper = HistoryHelper();
    super.initState();
  }

  late String namaText;
  late Customer customer;
  late CollectionReference collection;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              FutureBuilder<bool>(
                  future: futureKumpulan(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    carts.sortByEventDate();
                    return ListView.builder(
                      itemBuilder: (context, i) {
                        MaterialColor leftColor;
                        MaterialColor rightColor;
                        if (carts[i].hasSend) {
                          leftColor = Colors.green;
                        } else {
                          leftColor = Colors.red;
                        }
                        if (carts[i].hasPay) {
                          rightColor = Colors.green;
                        } else {
                          rightColor = Colors.red;
                        }
                        if (carts[i].hasSend && carts[i].hasPay) {
                          History history = History(
                            buySell: carts[i].buySell,
                            customerName: carts[i].customer.name,
                            dateTime: carts[i].dateTime,
                            dropPoint: carts[i].dropPoint,
                            cartItems: carts[i].cartItems,
                            orderNumber: carts[i].orderNumber,
                            totalPrice: carts[i].totalPrice,
                          );
                          _historyHelper.write(history);
                          return Container();
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return CartScreen(
                                    cart: carts[i],
                                  );
                                },
                              ),
                            );
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            margin: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                border: Border.all(style: BorderStyle.solid)),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Customers",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              carts[i].customer.name,
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
                                          if (carts[i].buySell) {
                                            return const Text("Beli");
                                          } else {
                                            return const Text("Jual");
                                          }
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Date",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            carts[i].dateString,
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
                                          color: leftColor,
                                          size: 30,
                                        ),
                                        onPressed: () async {
                                          var x = await showDialog<bool>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Apakah sudah dikirim'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: const <Widget>[
                                                      Text(
                                                          'Pastikan Barang sudah dikirim'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Sudah'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: const Text("Batal"),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                          collection
                                              .doc(carts[i].orderNumber)
                                              .update({"hassend": x});
                                          setState(() {});
                                          // return x;
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
                                          color: rightColor,
                                          size: 30,
                                        ),
                                        onPressed: () async {
                                          var x = await showDialog<bool>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Apakah sudah dibayar'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: const <Widget>[
                                                      Text(
                                                          'Pastikan Barang sudah dibayar'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Sudah'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: const Text("Batal"),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                          collection
                                              .doc(carts[i].orderNumber)
                                              .update({"haspay": x});
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const Text("Price"),
                                          Text(carts[i].totalPrice.toString()),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: carts.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> futureKumpulan() async {
    carts = [];

    var listofcart = await _cartHelper.listFuture();
    carts = listofcart.toList();
    return true;
  }
}
