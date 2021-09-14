import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/ordersproduct.dart';
import 'package:new_flutter_mbdimsum/models/products.dart';

class CartProductsPage extends StatefulWidget {
  OrderProducts products;
  bool buysell;
  CartProductsPage({
    this.products,
    this.buysell,
  });

  @override
  _CartProductsPageState createState() => _CartProductsPageState();
}

class _CartProductsPageState extends State<CartProductsPage> {
  FirebaseFirestore firestore;
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
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  style: BorderStyle.solid,
                ),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Product Name",
                  hintText: "e.g Joko.",
                  border: InputBorder.none,
                  enabled: false,
                ),
                controller: TextEditingController(
                    text: widget.products.productname ?? ""),
                readOnly: true,
                onChanged: (String ans) {
                  widget.products.productname = ans;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(
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
                    text: widget.products.price.toString() ?? ""),
                decoration: InputDecoration(
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
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(
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
                    text: widget.products.quantity.toString() ?? ""),
                decoration: InputDecoration(
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
                          title: Text('Error'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Jumlah yang dimasukkan melebih stock'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Ok'),
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
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
