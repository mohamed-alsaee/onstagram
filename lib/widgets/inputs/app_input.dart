import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onstagram/helpers/consts.dart';

class AppInput extends StatelessWidget {
  const new({
    super.key,
    required this.controller,
    this.label,
    this.hPadding = 16,
    this.vPadding = 8,
    this.keyboardType = TextInputType.text,
    this.digitsOnly = false,
    required this.validator,
    this.customHint,
    this.prefix,
    this.suffix,
    this.underWidget,
    this.showValue = true,
    required this.onChanged,
    this.enabled = true,
  });
  final TextEditingController controller;
  final String? label;
  final double hPadding;
  final double vPadding;
  final TextInputType? keyboardType;
  final bool digitsOnly;
  final FormFieldValidator<String>? validator;
  final String? customHint;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? underWidget;
  final bool? showValue;
  final Function onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(label!, style: labelSmall),
            ),
          TextFormField(
            enabled: enabled,
            // onEditingComplete: onEditingComplete(),
            // onFieldSubmitted: onEditingComplete(),
            onChanged: (value) {
              onChanged();
            },
            obscureText: !showValue!,
            inputFormatters: <TextInputFormatter>[
              digitsOnly
                  ? FilteringTextInputFormatter.digitsOnly
                  : FilteringTextInputFormatter.deny(""),
            ],
            validator: validator,
            keyboardType: keyboardType,
            controller: controller,
            style: labelSmall,
            decoration: InputDecoration(
              prefixIcon: prefix,
              suffixIcon: suffix,

              hintText: customHint ?? "Enter $label",
              hintStyle: bodyMedium.copyWith(color: Colors.grey),
            ),
          ),
          ?underWidget,
        ],
      ),
    );
  }
}
