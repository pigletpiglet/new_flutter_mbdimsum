import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/mutation.dart';
import 'package:new_flutter_mbdimsum/models/products.dart';
import 'package:new_flutter_mbdimsum/extensions/mutation_extensions.dart';

class ProductMutationPage extends StatefulWidget {
  final Products products;
  const ProductMutationPage({Key? key, required this.products})
      : super(key: key);
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
                List<Mutation> datalists = [];
                for (var detes in data) {
                  datalists.add(Mutation.fromMap(detes.data()));
                }
                if (datalists.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(15),
                          child: const Text(
                              "Maaf Belum ada sejarah mutasi untuk item ini")),
                    ],
                  );
                }
                datalists.sortByEventDate();
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
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
                                      const Text("Tanggal :"),
                                      Text(datalists[i].dateString)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Mutasi :"),
                                      Builder(
                                        builder: (context) {
                                          if (datalists[i].buySell) {
                                            return const Icon(Icons.add,
                                                color: Colors.green);
                                          } else {
                                            return const Icon(Icons.remove,
                                                color: Colors.red);
                                          }
                                        },
                                      ),
                                      Text(datalists[i].quantity.toString())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Customer : "),
                                      Text(datalists[i].customerName)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Price : "),
                                      Text(datalists[i].price.toString())
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const Text("Total :"),
                                Text(datalists[i].stock.toString())
                              ],
                            )
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
    );
  }
}
