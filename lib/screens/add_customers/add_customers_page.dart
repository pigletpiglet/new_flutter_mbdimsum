import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer_helper.dart';
import 'package:new_flutter_mbdimsum/widgets/normal_input.dart';

class AddCustomersPage extends StatefulWidget {
  @override
  _AddCustomersPageState createState() => _AddCustomersPageState();
}

class _AddCustomersPageState extends State<AddCustomersPage> {
  late Customer customer;
  late CustomerHelper _customerHelper;
  @override
  void initState() {
    customer = Customer.empty();
    _customerHelper = CustomerHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: const Text(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                child: const Text("Save"),
                onPressed: () async {
                  customer.id = customer.getRandomString(8);
                  _customerHelper.write(customer);

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
