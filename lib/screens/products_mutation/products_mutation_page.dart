import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/models/Mutation/mutation.dart';
import 'package:new_flutter_mbdimsum/models/Mutation/mutation_helper.dart';
import 'package:new_flutter_mbdimsum/models/Products/products.dart';

class ProductMutationPage extends StatefulWidget {
  Products products;
  ProductMutationPage({required this.products});
  MutationHelper mutationHelper = MutationHelper();
  @override
  _ProductMutationPageState createState() => _ProductMutationPageState();
}

class _ProductMutationPageState extends State<ProductMutationPage> {
  @override
  Widget build(BuildContext context) {
    widget.mutationHelper.productID = widget.products.productId;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 30,
            ),
            child: const Text(
              "Mutasi Produk",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<List<Mutation>>(
              // future: widget.mutationHelper.list(),
              builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            var datalist = snapshot.data;
            if (datalist?.isEmpty ?? true) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                          "Maaf Belum ada sejarah mutasi untuk item ini")),
                ],
              );
            }
            // datalist.sortByEventDate();
            return ListView.builder(
              itemBuilder: (context, i) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text("Tanggal :"),
                                  Text(datalist?[i].dateString ?? "")
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Mutasi :"),
                                  Builder(
                                    builder: (context) {
                                      if (datalist?[i].buySell ?? false) {
                                        return const Icon(Icons.add,
                                            color: Colors.green);
                                      } else {
                                        return const Icon(Icons.remove,
                                            color: Colors.red);
                                      }
                                    },
                                  ),
                                  Text(datalist?[i].quantity.toString() ?? "")
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Customer : "),
                                  Text(datalist?[i].customerName ?? "")
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Price : "),
                                  Text(datalist?[i].price.toString() ?? "0")
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const Text("Total :"),
                            Text(datalist?[i].stock.toString() ?? "0")
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: datalist?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            );
          }),
        ],
      ),
    );
  }
}
