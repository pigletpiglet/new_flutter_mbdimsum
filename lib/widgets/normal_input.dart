import 'package:flutter/material.dart';

class NormalInput extends StatefulWidget {
  Function(String)? function;
  String? hintText, labelText;
  TextInputType? keyboardType;

  NormalInput(
      {Key? key,
      this.function,
      this.labelText,
      this.hintText,
      this.keyboardType})
      : super(key: key);

  @override
  _NormalInputState createState() => _NormalInputState();
}

class _NormalInputState extends State<NormalInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        border: const Border(
            bottom: BorderSide(
          color: Colors.blue,
          style: BorderStyle.solid,
        )),
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType,
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
