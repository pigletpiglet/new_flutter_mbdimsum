import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool italic;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final String? fontFamily;

  const CustomText(
    this.text, {
    this.fontFamily,
    this.color,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.textAlign,
    this.italic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
