import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';

class AppInput extends StatelessWidget {
  const new({
    super.key,
    required this.controller,
    this.label,
    this.hPadding = 16,
    this.vPadding = 8,
  });
  final TextEditingController controller;
  final String? label;
  final double hPadding;
  final double vPadding;

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
            controller: controller,
            style: labelSmall,
            decoration: InputDecoration(
              hintText: "Enter $label",
              hintStyle: bodyMedium.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
