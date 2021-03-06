import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Mutation/mutation_helper.dart';
import 'package:new_flutter_mbdimsum/models/Products/products_helper.dart';
import 'package:new_flutter_mbdimsum/models/cart_items/cart_items_helper.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart_helper.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';
import 'package:new_flutter_mbdimsum/models/cart_items/cart_items.dart';
import 'package:new_flutter_mbdimsum/screens/add_carts/add_carts_screen.dart';
import 'package:new_flutter_mbdimsum/screens/cart_products/cart_products_screen.dart';
import 'package:new_flutter_mbdimsum/screens/customers/customers_screen.dart';
import 'package:new_flutter_mbdimsum/widgets/base_form_field.dart';
import 'package:new_flutter_mbdimsum/widgets/custom_button.dart';
import 'package:new_flutter_mbdimsum/widgets/list_card.dart';
import 'package:new_flutter_mbdimsum/widgets/sell_buy_button.dart';

class CartPage extends StatefulWidget {
  Cart? cart;
  CartPage({Key? key, this.cart}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartHelper _cartHelper = CartHelper();
  final MutationHelper _mutationHelper = MutationHelper();
  final ProductsHelper _productsHelper = ProductsHelper();

  late FirebaseFirestore firestore;
  late Cart pesanan;

  late bool isUpdate;

  late List<CartItems> delete;

  @override
  void initState() {
    delete = [];

    if (widget.cart != null) {
      widget.cart = widget.cart?.isEmpty() ?? true ? Cart.empty() : widget.cart;
      isUpdate = true;
    } else {
      widget.cart = Cart.empty();
      isUpdate = false;
    }

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
                CustomButton(
                  function: () async {
                    widget.cart!.customer = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CustomersScreen();
                        },
                      ),
                    );

                    setState(() {});
                  },
                  text: widget.cart!.customer.name.isNotEmpty
                      ? widget.cart!.customer.name
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BaseFormField(
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    icon: Icons.map,
                    text: widget.cart?.customer.address ?? "",
                    hintText: "Address",
                    labelText: "Alamat",
                    onChanged: (val) => widget.cart!.dropPoint = val,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var content = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddCartsScreen();
                        },
                      ),
                    );
                    var product = CartItemsHelper().productToCartItems(content);
                    if (product != null) widget.cart?.cartItems.add(product);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        style: BorderStyle.none,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const Text("Pesanan"),
                        ListView.builder(
                          itemBuilder: (context, i) {
                            return Container(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                        onTap: () async {
                                          widget.cart!.cartItems[i] =
                                              (await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return CartProductsScreen(
                                                  cartItems: widget
                                                          .cart?.cartItems[i] ??
                                                      CartItems.empty(),
                                                  buysell:
                                                      widget.cart?.buySell ??
                                                          false,
                                                );
                                              },
                                            ),
                                          ));

                                          setState(() {});
                                        },
                                        child: ListCard(
                                          cardsName: widget.cart?.cartItems[i]
                                                  .itemName ??
                                              "",
                                          cardsType: "Products",
                                          icons: Icons.shopping_bag,
                                          quantity: widget.cart?.cartItems[i]
                                                  .quantity ??
                                              0,
                                          price:
                                              widget.cart?.cartItems[i].price ??
                                                  0,
                                        )),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      delete.add(widget.cart!.cartItems[i]);
                                      widget.cart?.cartItems.removeAt(i);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: widget.cart?.cartItems.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ],
                    ),
                  ),
                ),
                SellBuyButton(
                  buySell: widget.cart?.buySell ?? false,
                  onTap: () {
                    widget.cart?.buySell = !widget.cart!.buySell;
                    setState(() {});
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (delete.isNotEmpty) {
                        for (var element in delete) {
                          var quantity = element.quantity;
                          _mutationHelper.delete(
                              widget.cart!.orderNumber, element.itemID);
                          _productsHelper.changeStock(element.itemID,
                              (widget.cart!.buySell ? -quantity : (quantity)));
                        }
                      }
                      if (isUpdate) {
                        _cartHelper.update(widget.cart!);
                      } else {
                        _cartHelper.write(widget.cart!);
                      }
                      _mutationHelper.writeList(
                          widget.cart!.cartItems, widget.cart ?? Cart.empty());
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
