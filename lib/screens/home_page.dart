import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';
import 'package:new_flutter_mbdimsum/screens/Cart/cart_screen.dart';

// import 'Add Customers/add_customers_screen.dart';
// import 'Add Products/add_products_screen.dart';
// import 'Check Orders/check_orders_screen.dart';
// import 'Products Check/products_check_screen.dart';

class HomePage extends StatelessWidget {
  String title;
  HomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  child: SizedBox(
                    width: 182,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_bag,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          child: const Text(
                            "Pesan (Jual / Beli)",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CartScreen(
                            cart: Cart.empty(),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 6),
              //   child: ElevatedButton(
              //     child: SizedBox(
              //       width: 159,
              //       child: Row(
              //         children: [
              //           const Icon(
              //             Icons.check_circle,
              //             size: 30,
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Container(
              //             margin: const EdgeInsets.symmetric(vertical: 30),
              //             child: const Text(
              //               "Check Pesanan",
              //               style: TextStyle(fontSize: 15),
              //             ),
              //           ),
              //         ],
              //         mainAxisAlignment: MainAxisAlignment.center,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.teal,
              //     ),
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) {
              //             return CheckOrdersScreen();
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 6),
              //   child: ElevatedButton(
              //     child: SizedBox(
              //       width: 203,
              //       child: Row(
              //         children: [
              //           const Icon(
              //             Icons.add_circle,
              //             size: 30,
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Container(
              //             margin: const EdgeInsets.symmetric(vertical: 30),
              //             child: const Text(
              //               "Tambah Produk Baru",
              //               style: TextStyle(fontSize: 15),
              //             ),
              //           ),
              //         ],
              //         mainAxisAlignment: MainAxisAlignment.center,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.teal,
              //     ),
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) {
              //             return AddProductsScreen();
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 6),
              //   child: ElevatedButton(
              //     child: SizedBox(
              //       width: 115,
              //       child: Row(
              //         children: [
              //           const Icon(
              //             Icons.repeat,
              //             size: 30,
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Container(
              //             margin: const EdgeInsets.symmetric(vertical: 30),
              //             child: const Text(
              //               "Cek Stock",
              //               style: TextStyle(fontSize: 15),
              //             ),
              //           ),
              //         ],
              //         mainAxisAlignment: MainAxisAlignment.center,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.teal,
              //     ),
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) {
              //             return ProductCheckScreen();
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 6),
              //   child: ElevatedButton(
              //     child: SizedBox(
              //       width: 182,
              //       child: Row(
              //         children: [
              //           const Icon(
              //             Icons.group_add,
              //             size: 30,
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Container(
              //             margin: const EdgeInsets.symmetric(vertical: 30),
              //             child: const Text(
              //               "Tambah Customer",
              //               style: TextStyle(fontSize: 15),
              //             ),
              //           ),
              //         ],
              //         mainAxisAlignment: MainAxisAlignment.center,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.teal,
              //     ),
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) {
              //             return AddCustomersScreen();
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
