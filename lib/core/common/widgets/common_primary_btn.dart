import 'package:branc_epl/core/constants/app_constants.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:branc_epl/utils/dimens/dimensions.dart';
import 'package:flutter/material.dart';

class CommonPrimaryButton extends StatefulWidget {
  const CommonPrimaryButton({
    super.key,
    required this.title,
    this.buttonColor,
    required this.onPressed,
    this.textColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.height = 54,
    this.borderRadius = 8,
    this.icon,
    this.leftIcon,
    this.iconBorderColor,
    this.isLoadingMode = false,
  });

  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Color? iconBorderColor;
  final Color? borderColor;
  final double borderWidth;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final Widget? leftIcon;
  final String title;
  final bool isLoadingMode;

  @override
  State<CommonPrimaryButton> createState() => _CommonPrimaryButtonState();
}

class _CommonPrimaryButtonState extends State<CommonPrimaryButton> {
  bool _canTap = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          side: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
            width: widget.borderWidth,
          ),
        ),
        backgroundColor: widget.onPressed == null
            ? blackShade3
            : widget.buttonColor,
        padding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        minimumSize: Size.fromHeight(widget.height),
        disabledBackgroundColor: blackShade4,
      ),
      onPressed: widget.onPressed != null ? () => press() : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (widget.leftIcon != null) ...<Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: widget.iconBorderColor ?? Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: widget.leftIcon,
            ),
            Gap.w8,
          ],
          if (widget.title.isNotEmpty)
            Expanded(
              child: Text(
                widget.title,
                style: f14w600(
                  color: widget.onPressed == null
                      ? white
                      : (widget.textColor ?? white),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if (widget.isLoadingMode)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          if (widget.icon != null) ...<Widget>[
            Gap.w8,
            DecoratedBox(
              decoration: BoxDecoration(
                color: widget.iconBorderColor ?? Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: widget.icon,
            ),
          ],
        ],
      ),
    );
  }

  void press() {
    if (_canTap) {
      _canTap = false;
      widget.onPressed!();
      Future.delayed(AppConstants.debounceTime, () {
        if (mounted) _canTap = true;
      });
    } else {
      debugPrint(
        "===================================CLICK IGNORED===================================",
      );
    }
  }
}
