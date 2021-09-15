import 'package:flutter/material.dart';

class SellBuyButton extends StatefulWidget {
  SellBuyButton({Key? key, this.onTap, this.buySell}) : super(key: key);

  Function? onTap;
  bool? buySell = false;

  @override
  _SellBuyButtonState createState() => _SellBuyButtonState();
}

class _SellBuyButtonState extends State<SellBuyButton> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          widget.buySell = !widget.buySell!;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          alignment: Alignment.center,
          width: 125,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Builder(
                builder: (context) {
                  MaterialColor color;
                  if (widget.buySell!) {
                    color = Colors.green;
                  } else {
                    color = Colors.red;
                  }
                  return Icon(
                    Icons.shopping_cart,
                    color: color,
                  );
                },
              ),
              Builder(
                builder: (context) {
                  if (widget.buySell!) {
                    return const Text(
                      "Beli",
                      style: TextStyle(fontSize: 20),
                    );
                  } else {
                    return const Text(
                      "Jual",
                      style: TextStyle(fontSize: 20),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
