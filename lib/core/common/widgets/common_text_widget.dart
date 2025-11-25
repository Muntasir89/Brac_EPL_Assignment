import 'package:flutter/material.dart';

class CommonTextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final bool shouldShowMultipleLine;
  final int? maxLines;
  final bool? softWrap;
  final bool selectable;
  final TextOverflow? overflowType;

  const CommonTextWidget({
    super.key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.left,
    this.shouldShowMultipleLine = true,
    this.maxLines = 1,
    this.softWrap,
    this.selectable = false,
    this.overflowType,
  });

  @override
  Widget build(BuildContext context) {
    if (shouldShowMultipleLine == false) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: (selectable)
            ? SelectableText(text, style: style, textAlign: textAlign)
            : Text(
                text,
                style: style,
                textAlign: textAlign,
                overflow: overflowType,
              ),
      );
    } else {
      return (selectable)
          ? SelectableText(text, style: style, textAlign: textAlign)
          : Text(
              text,
              style: style,
              textAlign: textAlign,
              overflow: overflowType,
            );
    }
  }
}
