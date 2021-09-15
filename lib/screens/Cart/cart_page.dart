import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';
import 'package:new_flutter_mbdimsum/models/Cart%20Items/cart_items.dart';
import 'package:new_flutter_mbdimsum/widgets/normal_input.dart';

class CartPage extends StatefulWidget {
  Cart? cart;
  CartPage({Key? key, this.cart}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late FirebaseFirestore firestore;
  late List<CartItems> cartItems;
  late Customer customer;
  late Cart pesanan;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                NormalInput(
                  hintText: "AAA",
                  prefixIcon: const Icon(Icons.supervised_user_circle),
                  text: "",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
