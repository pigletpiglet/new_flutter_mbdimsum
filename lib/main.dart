import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/cart.dart';
import 'package:new_flutter_mbdimsum/screens/Add%20Customers/addcustomersScreen.dart';
import 'package:new_flutter_mbdimsum/screens/Add%20Products/addproductsScreen.dart';
import 'package:new_flutter_mbdimsum/screens/Check%20Orders/checkordersScreen.dart';
import 'package:new_flutter_mbdimsum/screens/Order%20Products/orderproductsScreen.dart';
import 'package:new_flutter_mbdimsum/screens/Product%20Checks/productcheckScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.purple,
          ),
        ),
      ),
      home: MyHomePage(title: 'MB Dimsum'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  // Cart order = Cart();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
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
                        return OrderProductsScreen(
                          order: widget.order,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                child: SizedBox(
                  width: 159,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: const Text(
                          "Check Pesanan",
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
                        return CheckOrdersScreen();
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                child: SizedBox(
                  width: 203,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_circle,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: const Text(
                          "Tambah Produk Baru",
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
                        return AddProductsScreen();
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                child: SizedBox(
                  width: 115,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.repeat,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: const Text(
                          "Cek Stock",
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
                        return ProductCheckScreen();
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                child: SizedBox(
                  width: 182,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.group_add,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: const Text(
                          "Tambah Customer",
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
                        return AddCustomersScreen();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
