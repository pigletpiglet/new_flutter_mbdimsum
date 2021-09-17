import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Products/products.dart';
import 'package:new_flutter_mbdimsum/models/Products/products_helper.dart';
import 'package:new_flutter_mbdimsum/screens/products_mutation/products_mutation_screen.dart';
import 'package:new_flutter_mbdimsum/widgets/list_card.dart';

class ProductChecksPage extends StatefulWidget {
  @override
  _ProductChecksPageState createState() => _ProductChecksPageState();
}

class _ProductChecksPageState extends State<ProductChecksPage> {
  late Products products;

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
                if (!snapshot.hasData) return Container();
                var itemList = snapshot.data?.toList() ?? [];
                itemList.sort((a, b) {
                  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                });
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductMutationScreen(
                                products: itemList[i],
                              );
                            },
                          ),
                        );
                      },
                      child: ListCard(
                        cardsName: itemList[i].name,
                        cardsType: "Products",
                        icons: Icons.shop,
                        price: itemList[i].price,
                        quantity: itemList[i].stock,
                      ),
                    );
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
