import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.minLines = 1,
    required this.labelText,
    this.controller,
    this.floatLabel = false,
    this.callback,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
  }) : super(key: key);

  final int minLines;
  final String labelText;
  final TextEditingController? controller;
  final bool floatLabel;
  final VoidCallback? callback;
  final String? Function(String?)? validator;
  final BorderRadius borderRadius;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      minLines: minLines,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: Theme.of(context).brightness != Brightness.dark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 12.0,
        ),
        floatingLabelBehavior: floatLabel ? null : FloatingLabelBehavior.never,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelText: labelText,
      ),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        color: Theme.of(context).brightness == Brightness.dark
            ? darkNeutralColor
            : lightDarkNeutralColor,
      ),
      inputFormatters: inputFormatters,
      onFieldSubmitted: (value) {
        if (callback == null) {
          return;
        }
        callback!();
      },
      validator: validator,
    );
  }
}
