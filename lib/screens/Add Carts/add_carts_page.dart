import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Products/products.dart';
import 'package:new_flutter_mbdimsum/models/Products/products_helper.dart';

class AddCartsPage extends StatefulWidget {
  @override
  _AddCartsPageState createState() => _AddCartsPageState();
}

class _AddCartsPageState extends State<AddCartsPage> {
  late Products products;
  late FirebaseFirestore firestore;
  late CollectionReference collection;
  late ProductsHelper _productsHelper;
  @override
  void initState() {
    _productsHelper = ProductsHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<Iterable<Products>>(
              future: _productsHelper.listFuture(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (!snapshot.hasData) return Container();
                var itemList = snapshot.data?.toList() ?? [];

                itemList.sort((a, b) {
                  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                });
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return Column(children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, itemList[i]);
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
                                text: itemList[i].name,
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
                  itemCount: itemList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                );
              }),
        ],
      ),
    );
  }
}
