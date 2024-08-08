import 'package:flutter/material.dart';
import 'package:frontend/styles/light_theme.dart';

class CustomAccentButton extends StatelessWidget {
  const CustomAccentButton({
    super.key,
    required this.onPressed,
    required this.buttonLabel,
    this.withShadow = false,
  });

  final Function() onPressed;
  final String buttonLabel;
  final bool withShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: lightAccentColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: withShadow
              ? [
                  const BoxShadow(
                    color: lightDarkNeutralColor,
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
          style: const TextStyle(
            fontSize: 17.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
