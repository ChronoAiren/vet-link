import 'package:flutter/material.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    Key? key,
    required this.labelText,
    this.controller,
    this.floatLabel = false,
    required this.dropdownItems,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.enabled = true,
  }) : super(key: key);

  final String labelText;
  final TextEditingController? controller;
  final bool floatLabel;
  final List<String> dropdownItems;
  final String? Function(String?)? validator;
  final BorderRadius borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedItem;

  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the dropdown items change, reset the selectedItem
    if (oldWidget.dropdownItems != widget.dropdownItems) {
      setState(() {
        selectedItem = null; // Reset the selected item
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      menuMaxHeight: 200,
      isExpanded: true,
      value: selectedItem,
      onChanged: widget.enabled
          ? (String? newValue) {
              setState(() {
                selectedItem = newValue;
              });
            }
          : null,
      validator: widget.validator,
      decoration: InputDecoration(
        filled: Theme.of(context).brightness != Brightness.dark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 14.0,
        ),
        floatingLabelBehavior:
            widget.floatLabel ? null : FloatingLabelBehavior.never,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? darkNeutralColor
                : lightDarkNeutralColor,
          ),
        ),
      ),
      items: widget.dropdownItems.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.dark
                  ? darkNeutralColor
                  : lightDarkNeutralColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}
