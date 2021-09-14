import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/customer.dart';
import 'package:new_flutter_mbdimsum/models/history.dart';
import 'package:new_flutter_mbdimsum/models/orders.dart';
import 'package:new_flutter_mbdimsum/models/ordersproduct.dart';
import 'package:new_flutter_mbdimsum/order_extensions.dart';

import 'package:new_flutter_mbdimsum/screens/Order%20Products/orderproductsScreen.dart';

class CheckOrdersPage extends StatefulWidget {
  @override
  _CheckOrdersPageState createState() => _CheckOrdersPageState();
}

class _CheckOrdersPageState extends State<CheckOrdersPage> {
  FirebaseFirestore firestore;
  QuerySnapshot col, subcol;
  List<Order> datalists;
  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    super.initState();
  }

  String namatext;
  Customer customer;
  CollectionReference collection;
  @override
  Widget build(BuildContext context) {
    collection = firestore.collection('Orders');

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              FutureBuilder<bool>(
                  future: futureKumpulan(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    datalists.sortByEventDate();
                    return ListView.builder(
                      itemBuilder: (context, i) {
                        var leftcolor, rightcolor;
                        if (datalists[i].hassend)
                          leftcolor = Colors.green;
                        else
                          leftcolor = Colors.red;
                        if (datalists[i].haspay)
                          rightcolor = Colors.green;
                        else
                          rightcolor = Colors.red;
                        if (datalists[i].hassend && datalists[i].haspay) {
                          History history = new History(
                            buysell: datalists[i].buysell,
                            customerName: datalists[i].customerName,
                            datetime: datalists[i].datetime,
                            droppoint: datalists[i].droppoint,
                            orderlists: datalists[i].orderlists,
                            orderNumber: datalists[i].orderNumber,
                            totalprice: datalists[i].totalprice,
                          );
                          firestore
                              .collection("History")
                              .doc(datalists[i].orderNumber)
                              .set(history.toVariables());
                          return Container();
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return OrderProductsScreen(
                                    order: datalists[i],
                                  );
                                },
                              ),
                            );
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                border: Border.all(style: BorderStyle.solid)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 15,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Customers",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              datalists[i].customerName,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Builder(
                                        builder: (context) {
                                          if (datalists[i].buysell)
                                            return Text("Beli");
                                          else
                                            return Text("Jual");
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Date",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            datalists[i].dateString,
                                            style: TextStyle(
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
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.shopping_cart,
                                          color: leftcolor,
                                          size: 30,
                                        ),
                                        onPressed: () async {
                                          var x = await showDialog<bool>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Apakah sudah dikirim'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(
                                                          'Pastikan Barang sudah dikirim'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Sudah'),
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
                                                    child: Text("Batal"),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                          collection
                                              .doc(datalists[i].orderNumber)
                                              .update({"hassend": x});
                                          setState(() {});
                                          return x;
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.payment,
                                          color: rightcolor,
                                          size: 30,
                                        ),
                                        onPressed: () async {
                                          var x = await showDialog<bool>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Apakah sudah dibayar'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(
                                                          'Pastikan Barang sudah dibayar'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Sudah'),
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
                                                    child: Text("Batal"),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                          collection
                                              .doc(datalists[i].orderNumber)
                                              .update({"haspay": x});
                                          setState(() {});
                                          return x;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text("Price"),
                                          Text(datalists[i]
                                              .totalprice
                                              .toString()),
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
                      itemCount: datalists.length ?? 0,
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
    col = await collection.get();
    datalists = [];
    for (var detes in col.docs) {
      var orderss = Order.fromMap(detes.data());
      orderss.orderlists = [];
      subcol = await collection
          .doc(orderss.orderNumber)
          .collection("Orderlists")
          .get();
      for (var dates in subcol.docs) {
        orderss.orderlists.add(OrderProducts.fromMap(dates.data()));
      }
      datalists.add(orderss);
    }
    return true;
  }
}
