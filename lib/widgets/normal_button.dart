import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  String? text;
  Function()? function;
  Icon? icon;

  NormalButton({this.text, this.function, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        child: SizedBox(
          width: 200,
          child: Row(
            children: [
              icon ?? const Icon(Icons.accessibility_new),
              const SizedBox(
                width: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  text ?? "",
                  style: const TextStyle(fontSize: 15, fontFamily: 'Ubuntu'),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
        ),
        onPressed: function,
      ),
    );
  }
}
