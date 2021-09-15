import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Products/products.dart';

class AddCartsPage extends StatefulWidget {
  @override
  _AddCartsState createState() => _AddCartsState();
}

class _AddCartsState extends State<AddCartsPage> {
  late Products products;
  late FirebaseFirestore firestore;
  late CollectionReference collection;

  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    collection = firestore.collection('Products');
    products = Products.empty();
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
                List<Products> datalists = [];
                for (var detes in data) {
                  datalists.add(Products.fromMap(detes.data()));
                }
                datalists.sort((a, b) {
                  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                });
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return Column(children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, datalists[i]);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 7.5,
                            horizontal: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: TextEditingController(
                                text: datalists[i].name,
                              ),
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.person),
                                labelText: "Products",
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
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
