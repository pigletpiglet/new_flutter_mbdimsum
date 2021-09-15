import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_text.dart';

class NormalInput extends StatelessWidget {
  final TextEditingController? _textEditingController = TextEditingController();
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final Widget? secondaryWidget;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final String Function(String?)? validator;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final Gradient? gradient;
  final bool? obscureText;
  final String? text;

  NormalInput(
      {this.labelText,
      this.hintText,
      this.text,
      this.secondaryWidget,
      this.onTap,
      this.onChanged,
      this.onFieldSubmitted,
      this.keyboardType,
      this.maxLines,
      this.maxLength,
      this.textCapitalization,
      this.textInputAction,
      this.validator,
      this.focusNode,
      this.readOnly,
      this.enabled,
      this.prefixIcon,
      this.suffixIcon,
      this.inputFormatters,
      this.decoration,
      this.controller,
      this.gradient,
      this.obscureText}) {
    _textEditingController?.text = text ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            CustomText(labelText ?? "", fontSize: 18),
            const SizedBox(width: 5),
            if (secondaryWidget != null) secondaryWidget!,
          ],
        ),
        TextFormField(
          obscureText: obscureText ?? false,
          enabled: enabled ?? true,
          readOnly: readOnly ?? false,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          focusNode: focusNode,
          validator: validator,
          controller: controller ?? _textEditingController,
          cursorWidth: 2.5,
          cursorRadius: const Radius.circular(10),
          style: const TextStyle(fontSize: 16),
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: decoration ??
              InputDecoration(
                hintText: hintText ?? "",
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
              ),
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          inputFormatters: inputFormatters ?? const [],
        ),
        const SizedBox(height: 12.5),
      ],
    );
  }
}
