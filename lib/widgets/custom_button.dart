import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function()? function;
  String? text;
  CustomButton({this.function, this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function ?? () {},
      // () async {
      //   customer = await Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return CustomersScreen();
      //       },
      //     ),
      //   );
      //   namatext = customer?.name ?? "";
      //   pesanan.customername = customer?.name ?? null;
      //   if (pesanan.droppoint == null)
      //     pesanan.droppoint = customer?.address ?? null;
      //   setState(() {});
      // },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(
            color: Colors.blue,
            style: BorderStyle.none,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.people),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Customer_dev"),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(text ?? "Masukkan Customer"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
