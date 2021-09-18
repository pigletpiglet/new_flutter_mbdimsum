import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Products/products.dart';
import 'package:new_flutter_mbdimsum/models/Products/products_helper.dart';
import 'package:new_flutter_mbdimsum/widgets/normal_input.dart';

class AddProductsPage extends StatefulWidget {
  @override
  _AddProductsPageState createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  late Products products;
  late ProductsHelper _productsHelper;
  @override
  void initState() {
    _productsHelper = ProductsHelper();
    products = Products.empty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: const Text(
                "Tambahkan Produk Baru",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            NormalInput(
              function: (String ans) {
                products.name = ans;
              },
              labelText: "Name",
              hintText: "e.g Buku.",
            ),
            NormalInput(
              function: (String ans) {
                products.stock = int.parse(ans);
              },
              labelText: "Stock",
              hintText: "e.g 10.",
            ),
            NormalInput(
              function: (String ans) {
                products.price = int.parse(ans);
              },
              labelText: "Price",
              hintText: "e.g 50000.",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                child: const Text("Save"),
                onPressed: () async {
                  products.productId = products.getRandomString(8);
                  _productsHelper.write(products);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
