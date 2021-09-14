import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  String cardsType;
  String cardsName;
  int quantity;
  int price;
  IconData? icons;

  ListCard({
    required this.cardsName,
    required this.cardsType,
    required this.quantity,
    this.icons,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              icons ?? Icons.shopping_bag,
              size: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardsType,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    cardsName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  Builder(builder: (context) {
                    if (price != null) {
                      return (Text(
                        "Rp. " + price.toString(),
                        style: const TextStyle(fontSize: 12),
                      ));
                    }
                    return Container();
                  })
                ],
              ),
            ),
            Builder(builder: (context) {
              if (quantity != null) {
                return Column(
                  children: [const Text("Quantity"), Text(quantity.toString())],
                );
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }
}
