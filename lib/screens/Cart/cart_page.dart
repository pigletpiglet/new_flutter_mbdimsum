import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart_helper.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';
import 'package:new_flutter_mbdimsum/models/Cart%20Items/cart_items.dart';
import 'package:new_flutter_mbdimsum/models/Products/products.dart';
import 'package:new_flutter_mbdimsum/screens/Add%20Carts/add_carts_screen.dart';
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
                GestureDetector(
                  onTap: () async {
                    Products orderProductsSementara =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddCartsScreen();
                        },
                      ),
                    );
                    // if (orderProductsSementara != null)
                    //   listoforderproducts.add(
                    //     OrderProducts(
                    //       price: orderProductsSementara.price,
                    //       productname: orderProductsSementara.name,
                    //       quantity: 1,
                    //       productid: orderProductsSementara.productid,
                    //       stock: orderProductsSementara.stock,
                    //     ),
                    //   );
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      border: Border.all(
                        color: Colors.blue,
                        style: BorderStyle.none,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.add,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: const Text(
                                "Add Products",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
