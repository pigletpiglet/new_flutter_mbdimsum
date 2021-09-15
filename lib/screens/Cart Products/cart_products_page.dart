import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Cart%20Items/cart_items.dart';

class CartProductsPage extends StatefulWidget {
  CartItems products;
  bool buysell;
  CartProductsPage({
    Key? key,
    required this.products,
    required this.buysell,
  }) : super(key: key);

  @override
  _CartProductsPageState createState() => _CartProductsPageState();
}

class _CartProductsPageState extends State<CartProductsPage> {
  late FirebaseFirestore firestore;
  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  style: BorderStyle.solid,
                ),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  hintText: "e.g Joko.",
                  border: InputBorder.none,
                  enabled: false,
                ),
                controller:
                    TextEditingController(text: widget.products.itemName),
                readOnly: true,
                onChanged: (String ans) {
                  widget.products.itemName = ans;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  style: BorderStyle.solid,
                ),
              ),
              child: TextFormField(
                controller: TextEditingController(
                    text: widget.products.price.toString()),
                decoration: const InputDecoration(
                  labelText: "Price",
                  hintText: "e.g 10000",
                  border: InputBorder.none,
                ),
                onChanged: (String ans) {
                  widget.products.price = int.parse(ans);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  style: BorderStyle.solid,
                ),
              ),
              child: TextFormField(
                controller: TextEditingController(
                    text: widget.products.quantity.toString()),
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  hintText: "e.g 5",
                  border: InputBorder.none,
                ),
                onChanged: (String ans) {
                  if (widget.buysell ||
                      widget.products.stock >= int.parse(ans)) {
                    widget.products.quantity = int.parse(ans);
                  } else {
                    showDialog<bool>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('Jumlah yang dimasukkan melebih stock'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {});
                  }
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, widget.products);
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
