import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart_helper.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';
import 'package:new_flutter_mbdimsum/models/Cart%20Items/cart_items.dart';
import 'package:new_flutter_mbdimsum/widgets/base_form_field.dart';
import 'package:new_flutter_mbdimsum/widgets/sell_buy_button.dart';

class CartPage extends StatefulWidget {
  Cart? cart;
  CartPage({Key? key, this.cart}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartHelper _cartHelper = CartHelper();

  late FirebaseFirestore firestore;
  late List<CartItems> cartItems;
  late Customer customer;
  late Cart pesanan;

  @override
  void initState() {
    widget.cart = widget.cart != null
        ? Cart.empty()
        : widget.cart!.isEmpty()
            ? widget.cart
            : Cart.empty();

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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BaseFormField(
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    icon: Icons.map,
                    hintText: "Address",
                    labelText: "Alamat",
                    onChanged: (val) => widget.cart!.dropPoint = val,
                  ),
                ),
                SellBuyButton(
                  buySell: widget.cart!.buySell,
                ),
                ElevatedButton(
                    onPressed: () {
                      _cartHelper.write(widget.cart!);
                      Navigator.pop(context);
                    },
                    child: const Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
