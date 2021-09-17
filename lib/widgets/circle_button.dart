import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  final IconData iconData;
  final void Function() onPressed;
  final Color color;
  final bool disabled;
  final double size;
  final double iconSize;
  final EdgeInsetsGeometry padding;

  const CircleButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    this.color = Colors.blue,
    this.disabled = false,
    this.size = 75.0,
    this.iconSize = 40.0,
    this.padding = const EdgeInsets.all(12),
  }) : super(key: key);

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: RawMaterialButton(
        onPressed: widget.disabled ? null : widget.onPressed,
        elevation: 2.0,
        fillColor: widget.color,
        child: Icon(
          widget.iconData,
          size: widget.iconSize,
          color: Colors.white,
        ),
        padding: widget.padding,
        shape: const CircleBorder(),
      ),
    );
  }
}
