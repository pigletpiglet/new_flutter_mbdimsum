import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/customer.dart';
import 'package:new_flutter_mbdimsum/widgets/normal_input.dart';

class AddCustomersPage extends StatefulWidget {
  @override
  _AddCustomersPageState createState() => _AddCustomersPageState();
}

class _AddCustomersPageState extends State<AddCustomersPage> {
  Customer customer;
  FirebaseFirestore firestore;
  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    customer = new Customer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text(
                "Tambahkan Customer",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            NormalInput(
              function: (String ans) {
                customer.name = ans;
              },
              labelText: "Name",
              hintText: "e.g Joko.",
            ),
            NormalInput(
              hintText: "e.g Jln. Mangga Besar",
              labelText: "Adress",
              function: (String ans) {
                customer.address = ans;
              },
            ),
            NormalInput(
              hintText: "e.g xxxxx@mail.com",
              labelText: "Email",
              function: (String ans) {
                customer.email = ans;
              },
            ),
            NormalInput(
              hintText: "e.g. 021xxxxxxx",
              labelText: "Phone Number",
              function: (String ans) {
                customer.phonenumber = int.parse(ans);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: ElevatedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    CollectionReference collectionReference =
                        firestore.collection("Customers");
                    collectionReference.doc().set(customer.toVariables());
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
