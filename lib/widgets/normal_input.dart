import 'package:flutter/material.dart';

class NormalInput extends StatefulWidget {
  Function(String) function;
  String hintText;
  String labelText;

  NormalInput({
    required this.function,
    required this.labelText,
    required this.hintText,
  });

  @override
  _NormalInputState createState() => _NormalInputState();
}

class _NormalInputState extends State<NormalInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.white,
        border: Border.all(
          color: Colors.blue,
          style: BorderStyle.solid,
        ),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
        onChanged: widget.function,
      ),
    );
  }
}
