import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/products.dart';
import 'package:new_flutter_mbdimsum/widgets/normal_input.dart';

class AddProductsPage extends StatefulWidget {
  @override
  _AddProductsPageState createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  Products products;
  FirebaseFirestore firestore;
  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    products = new Products();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text(
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
              child: Container(
                child: ElevatedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    products.productid = products.getRandomString(8);
                    CollectionReference collectionReference =
                        firestore.collection("Products");
                    collectionReference
                        .doc(products.productid)
                        .set(products.toVariables());
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
