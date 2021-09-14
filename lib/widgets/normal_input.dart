import 'package:flutter/material.dart';

class NormalInput extends StatefulWidget {
  Function(String) function;
  String hintText;
  String labelText;

  NormalInput({
    Key? key,
    required this.function,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  @override
  _NormalInputState createState() => _NormalInputState();
}

class _NormalInputState extends State<NormalInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.all(
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
