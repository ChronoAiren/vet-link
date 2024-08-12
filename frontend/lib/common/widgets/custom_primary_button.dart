import 'package:flutter/material.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.onPressed,
    required this.buttonLabel,
    this.withShadow = false,
    this.enabled = true,
  });

  final Function() onPressed;
  final String buttonLabel;
  final bool withShadow;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: enabled ? lightSecondaryColor : Colors.grey[300],
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: withShadow
              ? [
                  const BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 2),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  )
                ]
              : null,
        ),
        child: Text(
          buttonLabel,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17.0,
            color: enabled ? Colors.white : Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
