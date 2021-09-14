import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/customer.dart';
import 'package:new_flutter_mbdimsum/models/cart.dart';
import 'package:new_flutter_mbdimsum/models/products.dart';
import 'package:new_flutter_mbdimsum/extensions/cart_extensions.dart';

class ProductMutationPage extends StatefulWidget {
  Products products;
  ProductMutationPage({Key? key, required this.products}) : super(key: key);
  @override
  _ProductMutationPageState createState() => _ProductMutationPageState();
}

class _ProductMutationPageState extends State<ProductMutationPage> {
  late FirebaseFirestore firestore;
  late CollectionReference collection;

  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    collection = firestore
        .collection('Products')
        .doc(widget.products.productId)
        .collection("Mutasi");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<QuerySnapshot>(
                  future: collection.get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    var document = snapshot.data;
                    var data = document!.docs;
                    List<Cart> datalists = [];
                    for (var detes in data) {
                      datalists.add(Cart.fromMap(detes.data()));
                    }
                    if (datalists.isEmpty)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                  "Maaf Belum ada sejarah mutasi untuk item ini")),
                        ],
                      );
                    datalists.sortByEventDate();
                    return ListView.builder(
                      itemBuilder: (context, i) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Tanggal :"),
                                          Text(datalists[i].dateString)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Mutasi :"),
                                          Builder(
                                            builder: (context) {
                                              if (datalists[i].buySell) {
                                                return Icon(Icons.add,
                                                    color: Colors.green);
                                              } else {
                                                return Icon(Icons.remove,
                                                    color: Colors.red);
                                              }
                                            },
                                          ),
                                          Text(datalists[i].quantity.toString())
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Customer : "),
                                          Text(datalists[i].customerName)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Price : "),
                                          Text(datalists[i].price.toString())
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text("Total :"),
                                    Text(datalists[i].stock.toString())
                                  ],
                                )
                                // Column(
                                //   children: [
                                //     Container(
                                //       padding: EdgeInsets.symmetric(
                                //         horizontal: 15,
                                //         vertical: 5,
                                //       ),
                                //       child: Text("Tanggal"),
                                //     ),
                                //     Container(
                                //       child: Text(datalists[i].dateString),
                                //     )
                                //   ],
                                // ),
                                // Column(
                                //   children: [
                                //     Container(
                                //         padding: EdgeInsets.symmetric(
                                //           horizontal: 15,
                                //           vertical: 5,
                                //         ),
                                //         child: Text("Mutasi")),
                                //     Row(
                                //       children: [
                                //         Builder(
                                //           builder: (context) {
                                //             if (datalists[i].buysell) {
                                //               return Icon(Icons.add,
                                //                   color: Colors.green);
                                //             } else {
                                //               return Icon(Icons.remove,
                                //                   color: Colors.red);
                                //             }
                                //           },
                                //         ),
                                //         Text(datalists[i].quantity.toString())
                                //       ],
                                //     )
                                //   ],
                                // ),
                                // Column(
                                //   children: [
                                //     Container(
                                //         padding: EdgeInsets.symmetric(
                                //           horizontal: 15,
                                //           vertical: 5,
                                //         ),
                                //         child: Text("Customer")),
                                //     Text(datalists[i].customername)
                                //   ],
                                // ),
                                // Column(
                                //   children: [
                                //     Container(
                                //         padding: EdgeInsets.symmetric(
                                //           horizontal: 15,
                                //           vertical: 5,
                                //         ),
                                //         child: Text("Harga")),
                                //     Text(datalists[i].price.toString())
                                //   ],
                                // ),
                                // Expanded(
                                //   child: Column(
                                //     children: [
                                //       Container(
                                //           padding: EdgeInsets.symmetric(
                                //             horizontal: 15,
                                //             vertical: 5,
                                //           ),
                                //           child: Text("Stock")),
                                //       Text(datalists[i].stock.toString())
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: document.docs.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  }),
            ],
          ),
        ) ??
        Column(
          children: [
            Text("Maaf Belum ada sejarah mutasi untuk item ini"),
          ],
        );
  }
}
