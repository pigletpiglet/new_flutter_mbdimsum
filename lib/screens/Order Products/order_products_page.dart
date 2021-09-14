import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/customer.dart';
import 'package:new_flutter_mbdimsum/models/mutation.dart';
import 'package:new_flutter_mbdimsum/models/cart.dart';
import 'package:new_flutter_mbdimsum/models/cart_items.dart';
import 'package:new_flutter_mbdimsum/models/products.dart';
import 'package:new_flutter_mbdimsum/screens/Add%20Carts/add_carts_screen.dart';
import 'package:new_flutter_mbdimsum/screens/Cart%20Products/cart_products_screen.dart';
import 'package:new_flutter_mbdimsum/screens/Customers/customers_screen.dart';
import 'package:new_flutter_mbdimsum/widgets/List_Card.dart';

class OrderProductsPage extends StatefulWidget {
  Cart cart;
  OrderProductsPage({Key? key, required this.cart}) : super(key: key);
  @override
  _OrderProductsPageState createState() => _OrderProductsPageState();
}

class _OrderProductsPageState extends State<OrderProductsPage> {
  late FirebaseFirestore firestore;
  late List<CartItems> cartItems;
  late String namaText;
  late Customer customer;
  late Cart pesanan;

  @override
  void initState() {
    pesanan = Cart.empty();
    pesanan.customerName = widget.cart.customerName;
    pesanan.dateString = widget.cart.dateString;
    pesanan.dateTime = widget.cart.dateTime;
    pesanan.dropPoint = widget.cart.dropPoint;
    pesanan.hasPay = widget.cart.hasPay;
    pesanan.cartItems = widget.cart.cartItems;
    pesanan.orderNumber = widget.cart.orderNumber;
    pesanan.timeStampString = widget.cart.timeStampString;
    pesanan.totalPrice = widget.cart.totalPrice;
    pesanan.buySell = widget.cart.buySell;

    cartItems = [];
    firestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    namaText = pesanan.customerName;
    if (pesanan.cartItems.isNotEmpty) cartItems = pesanan.cartItems;
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              customer = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CustomersScreen();
                  },
                ),
              );
              namaText = customer.name;
              pesanan.customerName = customer.name;
              if (pesanan.dropPoint == null) {
                pesanan.dropPoint = customer.address;
              }
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                  color: Colors.blue,
                  style: BorderStyle.none,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Customer"),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(namaText ?? "Masukkan Customer"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  style: BorderStyle.none,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: TextFormField(
              onChanged: (String ans) {
                pesanan.dropPoint = ans;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.map),
                labelText: "Drop Point",
              ),
              style: const TextStyle(
                fontSize: 16,
              ),
              controller: TextEditingController(
                text: pesanan.dropPoint,
              ),
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
              if (orderProductsSementara != null) {
                cartItems.add(
                  CartItems(
                    price: orderProductsSementara.price,
                    itemName: orderProductsSementara.name,
                    quantity: 1,
                    itemID: orderProductsSementara.productId,
                    stock: orderProductsSementara.stock,
                  ),
                );
              }
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(100)),
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
          Container(
            alignment: Alignment.center,
            width: 125,
            child: Row(
              children: [
                Builder(
                  builder: (context) {
                    MaterialColor color;
                    if (pesanan.buySell) {
                      color = Colors.green;
                    } else {
                      color = Colors.red;
                    }
                    return IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: color,
                      ),
                      onPressed: () {
                        if (pesanan.buySell) {
                          pesanan.buySell = false;
                        } else {
                          pesanan.buySell = true;
                        }
                        setState(() {});
                      },
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    if (pesanan.buySell) {
                      return const Text("Beli");
                    } else {
                      return const Text("Jual");
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                style: BorderStyle.solid,
              ),
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
                                  CartItems listCartItems =
                                      await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                    builder: (context) {
                                      return CartProductsScreen(
                                        cartItems: cartItems[i],
                                        buysell: pesanan.buySell,
                                      );
                                    },
                                  ));
                                  if (listCartItems.itemName.isNotEmpty) {
                                    cartItems[i] = listCartItems;
                                  }
                                  setState(() {});
                                },
                                child: ListCard(
                                  cardsName: cartItems[i].itemName,
                                  cardsType: "Products",
                                  icons: Icons.shopping_bag,
                                  quantity: cartItems[i].quantity,
                                  price: cartItems[i].price,
                                )),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              cartItems.removeAt(i);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: cartItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Mutation x = Mutation.empty();
                pesanan.dateTime = pesanan.dateTime;
                pesanan.hasPay = pesanan.hasPay;
                pesanan.hasSend = pesanan.hasSend;
                pesanan.cartItems = cartItems;
                pesanan.totalPrice = pesanan.getTotalPrice();
                if (pesanan.orderNumber.isNotEmpty) {
                  pesanan.orderNumber = pesanan.getRandomString(8);
                  firestore
                      .collection("Orders")
                      .doc(pesanan.orderNumber)
                      .set(pesanan.toVariables());
                  for (var detes in cartItems) {
                    x.buySell = pesanan.buySell;
                    x.customerName = pesanan.customerName;
                    x.dateTime = pesanan.dateTime;
                    x.quantity = detes.quantity;
                    x.price = detes.price;
                    x.total = x.quantity * x.price;
// Write Order
                    firestore
                        .collection("Orders")
                        .doc(pesanan.orderNumber)
                        .collection("Orderlists")
                        .doc(pesanan.orderNumber + detes.itemName)
                        .set(detes.toVariables());

                    int itung;
                    if (x.buySell) {
                      itung = detes.stock + x.quantity;
                    } else {
                      itung = detes.stock - x.quantity;
                    }
                    x.stock = itung;
                    //Write Stock
                    firestore
                        .collection("Products")
                        .doc(detes.itemID)
                        .update({"stock": itung});
                    //Write Mutasi
                    firestore
                        .collection("Products")
                        .doc(detes.itemID)
                        .collection("Mutasi")
                        .doc(pesanan.orderNumber)
                        .set(x.toVariables());
                  }
                } else {
                  firestore
                      .collection("Orders")
                      .doc(pesanan.orderNumber)
                      .update(pesanan.toVariables());
                  for (var detes in cartItems) {
                    x.buySell = pesanan.buySell;
                    x.customerName = pesanan.customerName;
                    x.dateTime = pesanan.dateTime;
                    x.quantity = detes.quantity;
                    x.price = detes.price;
                    x.total = x.quantity * x.price;

                    int itung;
// Update Order
                    firestore
                        .collection("Orders")
                        .doc(pesanan.orderNumber)
                        .collection("Orderlists")
                        .doc(pesanan.orderNumber + detes.itemName)
                        .update(detes.toVariables());
// Update Stock
                    if (x.buySell) {
                      itung = detes.stock + x.quantity;
                    } else {
                      itung = detes.stock - x.quantity;
                    }
                    x.stock = itung;
                    firestore
                        .collection("Products")
                        .doc(detes.itemID)
                        .update({"stock": itung});

// Update Mutasi
                    firestore
                        .collection("Products")
                        .doc(detes.itemID)
                        .collection("Mutasi")
                        .doc(pesanan.orderNumber)
                        .update(x.toVariables());
                  }
                }

                pesanan = Cart.empty();
                Navigator.pop(context);
              },
              child: const Text("Save"))
        ],
      ),
    );
  }
}
