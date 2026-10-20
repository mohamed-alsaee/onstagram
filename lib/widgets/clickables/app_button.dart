import 'package:flutter/material.dart';

import '../../helpers/consts.dart';

class AppButton extends StatefulWidget {
  const new({
    super.key,
    required this.onPressed,
    required this.label,
    required this.btnColor,
    this.txtColor,
    this.withBorder = false,
    this.hPadding = 16,
    this.vPadding = 16,
    this.isLoading = false,
    this.enabled = true,
  });
  final Function onPressed;
  final String label;
  final Color btnColor;
  final Color? txtColor;
  final bool withBorder;
  final double hPadding;
  final double vPadding;
  final bool enabled;
  final bool isLoading;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.hPadding,
        vertical: widget.vPadding,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: 1,
                color: widget.withBorder
                    ? widget.txtColor ?? whiteColor
                    : widget.btnColor,
              ),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(widget.btnColor),
        ),
        onPressed: () {
          if (widget.enabled || !widget.isLoading) {
            widget.onPressed();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: widget.isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: widget.txtColor ?? whiteColor,
                        ),
                      )
                    : Text(
                        widget.label,
                        style: labelSmall.copyWith(
                          color: widget.txtColor ?? whiteColor,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
