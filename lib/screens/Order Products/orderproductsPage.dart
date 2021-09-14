import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/customer.dart';
import 'package:new_flutter_mbdimsum/models/mutation.dart';
import 'package:new_flutter_mbdimsum/models/orders.dart';
import 'package:new_flutter_mbdimsum/models/ordersproduct.dart';
import 'package:new_flutter_mbdimsum/models/products.dart';
import 'package:new_flutter_mbdimsum/screens/Add%20Carts/addcartsScreen.dart';
import 'package:new_flutter_mbdimsum/screens/Cart%20Products/cartproductsScreen.dart';
import 'package:new_flutter_mbdimsum/screens/Customers/customersScreen.dart';
import 'package:new_flutter_mbdimsum/widgets/List_Cards.dart';

class OrderProductsPage extends StatefulWidget {
  Order order;
  OrderProductsPage({this.order});
  @override
  _OrderProductsPageState createState() => _OrderProductsPageState();
}

class _OrderProductsPageState extends State<OrderProductsPage> {
  FirebaseFirestore firestore;
  List<OrderProducts> listoforderproducts;
  String namatext;
  Customer customer;
  Order pesanan;

  @override
  void initState() {
    pesanan = new Order();
    pesanan.customerName = widget.order.customerName;
    pesanan.dateString = widget.order.dateString;
    pesanan.datetime = widget.order.datetime;
    pesanan.droppoint = widget.order.droppoint;
    pesanan.haspay = widget.order.haspay;
    pesanan.orderlists = widget.order.orderlists;
    pesanan.orderNumber = widget.order.orderNumber;
    pesanan.timeStampString = widget.order.timeStampString;
    pesanan.totalprice = widget.order.totalprice;
    pesanan.buysell = widget.order.buysell ?? false;

    // namatext = widget.order.customername ?? null;
    listoforderproducts = [];
    firestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    namatext = pesanan.customerName ?? null;
    if (pesanan.orderlists != null) listoforderproducts = pesanan.orderlists;
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
              namatext = customer?.name ?? "";
              pesanan.customerName = customer?.name ?? null;
              if (pesanan.droppoint == null)
                pesanan.droppoint = customer?.address ?? null;
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                  color: Colors.blue,
                  style: BorderStyle.none,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    child: Icon(Icons.people),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Customer"),
                          SizedBox(
                            height: 4,
                          ),
                          Text(namatext ?? "Masukkan Customer"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            padding: EdgeInsets.symmetric(
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
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: TextFormField(
              onChanged: (String ans) {
                pesanan.droppoint = ans;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.map),
                labelText: "Drop Point",
              ),
              style: const TextStyle(
                fontSize: 16,
              ),
              controller: TextEditingController(
                text: pesanan.droppoint ?? "",
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
              if (orderProductsSementara != null)
                listoforderproducts.add(
                  OrderProducts(
                    price: orderProductsSementara.price,
                    productname: orderProductsSementara.name,
                    quantity: 1,
                    productid: orderProductsSementara.productid,
                    stock: orderProductsSementara.stock,
                  ),
                );
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                  color: Colors.blue,
                  style: BorderStyle.none,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.add,
                      size: 25,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: Text(
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
                    var color;
                    if (pesanan.buysell)
                      color = Colors.green;
                    else
                      color = Colors.red;
                    return Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: color,
                        ),
                        onPressed: () {
                          if (pesanan.buysell) {
                            pesanan.buysell = false;
                          } else {
                            pesanan.buysell = true;
                          }
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    if (pesanan.buysell)
                      return Text("Beli");
                    else
                      return Text("Jual");
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
                Container(
                  child: Text("Pesanan"),
                ),
                ListView.builder(
                  itemBuilder: (context, i) {
                    return Container(
                      padding: EdgeInsets.all(6),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: InkWell(
                                  onTap: () async {
                                    OrderProducts sementara =
                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                      builder: (context) {
                                        return CartProductsScreen(
                                          products: listoforderproducts[i],
                                          buysell: pesanan.buysell,
                                        );
                                      },
                                    ));
                                    if (sementara?.productname != null)
                                      listoforderproducts[i] = sementara;
                                    setState(() {});
                                  },
                                  child: ListCards(
                                    cardsName:
                                        listoforderproducts[i].productname,
                                    cardsType: "Products",
                                    icons: Icons.shopping_bag,
                                    quantity: listoforderproducts[i].quantity,
                                    price: listoforderproducts[i].price,
                                  )),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              listoforderproducts.removeAt(i);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: listoforderproducts.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Mutation x = new Mutation();
                pesanan.datetime = pesanan.datetime ?? DateTime.now();
                pesanan.haspay = pesanan.haspay ?? false;
                pesanan.hassend = pesanan.haspay ?? false;
                pesanan.orderlists = listoforderproducts ?? [];
                pesanan.totalprice = pesanan.getTotalPrice() ?? 0;
                if (pesanan.orderNumber == null) {
                  pesanan.orderNumber = pesanan.getRandomString(8);
                  firestore
                      .collection("Orders")
                      .doc(pesanan.orderNumber)
                      .set(pesanan.toVariables());
                  for (var detes in listoforderproducts) {
                    x.buysell = pesanan.buysell;
                    x.customerName = pesanan.customerName;
                    x.datetime = pesanan.datetime;
                    x.quantity = detes.quantity;
                    x.price = detes.price;
                    x.total = x.quantity * x.price;
// Write Order
                    firestore
                        .collection("Orders")
                        .doc(pesanan.orderNumber)
                        .collection("Orderlists")
                        .doc(pesanan.orderNumber + detes.productname)
                        .set(detes.toVariables());

                    var itung;
                    if (x.buysell) {
                      itung = detes.stock + x.quantity;
                    } else {
                      itung = detes.stock - x.quantity;
                    }
                    x.stock = itung;
                    //Write Stock
                    firestore
                        .collection("Products")
                        .doc(detes.productid)
                        .update({"stock": itung});
                    //Write Mutasi
                    firestore
                        .collection("Products")
                        .doc(detes.productid)
                        .collection("Mutasi")
                        .doc(pesanan.orderNumber)
                        .set(x.toVariables());
                  }
                } else {
                  firestore
                      .collection("Orders")
                      .doc(pesanan.orderNumber)
                      .update(pesanan.toVariables());
                  for (var detes in listoforderproducts) {
                    x.buysell = pesanan.buysell;
                    x.customerName = pesanan.customerName;
                    x.datetime = pesanan.datetime;
                    x.quantity = detes.quantity;
                    x.price = detes.price;
                    x.total = x.quantity * x.price;

                    var itung;
// Update Order
                    firestore
                        .collection("Orders")
                        .doc(pesanan.orderNumber)
                        .collection("Orderlists")
                        .doc(pesanan.orderNumber + detes.productname)
                        .update(detes.toVariables());
// Update Stock
                    if (x.buysell) {
                      itung = detes.stock + x.quantity;
                    } else {
                      itung = detes.stock - x.quantity;
                    }
                    x.stock = itung;
                    firestore
                        .collection("Products")
                        .doc(detes.productid)
                        .update({"stock": itung});

// Update Mutasi
                    firestore
                        .collection("Products")
                        .doc(detes.productid)
                        .collection("Mutasi")
                        .doc(pesanan.orderNumber)
                        .update(x.toVariables());
                  }
                }

                pesanan = new Order();
                Navigator.pop(context);
              },
              child: Text("Save"))
        ],
      ),
    );
  }
}
