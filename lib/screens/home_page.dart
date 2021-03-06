import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/screens/Cart/cart_screen.dart';
import 'package:new_flutter_mbdimsum/screens/products_check/products_check_screen.dart';
import 'package:new_flutter_mbdimsum/widgets/bigiconbutton.dart';

import 'add_customers/add_customers_screen.dart';
import 'add_products/add_products_screen.dart';
import 'check_orders/check_orders_screen.dart';

class HomePage extends StatelessWidget {
  String title;
  HomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'MB Dimsum',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Text(
                    'Pilih Layanan',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Row(
                  children: [
                    BigIconButton(
                      color: Colors.green,
                      function: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CheckOrdersScreen();
                        }));
                      },
                      iconData: Icons.check_circle,
                      label: "Check \n Pesanan",
                    ),
                    BigIconButton(
                      color: Colors.lightBlue,
                      function: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CartScreen();
                        }));
                      },
                      iconData: Icons.shopping_cart_rounded,
                      label: "Pesan \n (Jual / Beli)",
                    ),
                  ],
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Row(
                  children: [
                    BigIconButton(
                      color: Colors.yellow[800]!,
                      function: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AddProductsScreen();
                            },
                          ),
                        );
                      },
                      iconData: Icons.add_circle,
                      label: "Tambah \n Produk Baru",
                    ),
                    BigIconButton(
                      color: Colors.red[400]!,
                      function: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductCheckScreen();
                        }));
                      },
                      iconData: Icons.repeat,
                      label: "Cek Stock",
                    ),
                  ],
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Row(
                  children: [
                    BigIconButton(
                      color: Colors.deepPurple,
                      function: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AddCustomersScreen();
                        }));
                      },
                      iconData: Icons.group_add,
                      label: "Tambah Customer",
                    ),
                  ],
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
