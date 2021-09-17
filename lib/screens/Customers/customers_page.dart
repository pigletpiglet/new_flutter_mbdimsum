import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer.dart';
import 'package:new_flutter_mbdimsum/models/Customer/customer_helper.dart';

class CustomersPage extends StatefulWidget {
  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  late CustomerHelper _customerHelper;

  @override
  void initState() {
    _customerHelper = CustomerHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<Iterable<Customer>>(
              future: _customerHelper.listFuture(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                var itemList = snapshot.data?.toList() ?? [];
                itemList.sort((a, b) {
                  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                });

                return ListView.builder(
                  itemBuilder: (context, i) {
                    return Column(children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, itemList[i]);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 7.5,
                            horizontal: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(
                              // color: Colors.white,
                              // border: Border.all(
                              //   color: Colors.blue,
                              //   style: BorderStyle.solid,
                              // ),
                              ),
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: TextEditingController(
                                text: itemList[i].name,
                              ),
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.person),
                                labelText: "Customer",
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  },
                  itemCount: itemList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                );
              }),
        ],
      ),
    );
  }
}
