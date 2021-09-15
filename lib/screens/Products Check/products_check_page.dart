import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Products/products.dart';
import 'package:new_flutter_mbdimsum/screens/Products%20Mutation/products_mutation_screen.dart';
import 'package:new_flutter_mbdimsum/widgets/list_card.dart';

class ProductChecksPage extends StatefulWidget {
  @override
  _ProductChecksPageState createState() => _ProductChecksPageState();
}

class _ProductChecksPageState extends State<ProductChecksPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Products products;

  @override
  Widget build(BuildContext context) {
    CollectionReference collection = firestore.collection('Products');

    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: collection.get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                QuerySnapshot? document = snapshot.data;
                var data = document?.docs ?? [];
                List<Products> datalists = [];
                for (var detes in data) {
                  datalists.add(Products.fromMap(detes.data()));
                }
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductMutationScreen(
                                products: datalists[i],
                              );
                            },
                          ),
                        );
                      },
                      child: ListCard(
                        cardsName: datalists[i].name,
                        cardsType: "Products",
                        icons: Icons.shop,
                        price: datalists[i].price,
                        quantity: datalists[i].stock,
                      ),
                    );
                  },
                  itemCount: document!.docs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                );
              }),
        ],
      ),
    );
  }
}
