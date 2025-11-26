import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:branc_epl/utils/dimens/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Updated by Muntasir Hossen [muntasirhossen1704089@gmail.com] on 18 September, 2025.

class CommonInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode; // Added optional focus node parameter
  final String? title;
  final String? labelText;
  final String hintText;
  final TextStyle? titleStyle;
  final TextStyle? inputTextStyle;
  final Color hintTextColor;
  final Color defaultBorderColor;
  final Color cursorColor;
  final Color backgroundColor;
  final int? maxLength;
  final int maxLines;
  final TextInputType? inputType;
  final EdgeInsets scPadding;
  final EdgeInsets? padding;
  final EdgeInsets contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final bool? enabled;
  final bool? obscureText;
  final bool autoFocus;
  final bool enableCopyPaste;
  final bool readOnly;
  final bool suffixIconAlwaysVisible; // New parameter for suffixIcon visibility
  final bool showLetterCounter;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final double? height;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final BorderRadius borderRadius; // Border radius parameter
  final VoidCallback? onSuffixIconPressed;

  const CommonInputField({
    super.key,
    required this.controller,
    this.focusNode, // Added focusNode parameter
    required this.hintText,
    this.inputType,
    this.obscureText,
    this.title,
    this.labelText,
    this.titleStyle,
    this.inputTextStyle,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled,
    this.onChanged,
    this.height,
    this.validator,
    this.onTap,
    this.inputFormatters,
    this.hintTextColor = grayShade1,
    this.cursorColor = black,
    this.autoFocus = false,
    this.scPadding = EdgeInsets.zero,
    this.padding,
    this.enableCopyPaste = true,
    this.readOnly = false,
    this.border,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedBorder,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 5,
    ),
    this.errorText,
    this.defaultBorderColor = inputStrokeOutside,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.onSuffixIconPressed,
    this.maxLines = 1,
    this.backgroundColor = frameBg, // Default background color
    this.suffixIconAlwaysVisible =
        false, // Default value for suffixIcon visibility
    this.showLetterCounter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          CommonTextWidget(
            text: title!,
            style: titleStyle ?? f14w400(color: black),
          ),
        if (title != null) Gap.h12,
        Container(
          height: height,
          margin: padding ?? EdgeInsets.zero,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: backgroundColor, // Apply the background color here
            borderRadius: borderRadius,
            // border: Border.all(color: borderColor),
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              onTap: onTap,
              autofocus: autoFocus,
              controller: controller,
              focusNode: focusNode,
              maxLength: maxLength,
              keyboardType: inputType,
              scrollPadding: scPadding,

              inputFormatters: [
                // default formatter to deny emojis
                FilteringTextInputFormatter.deny(
                  RegExp(
                    r'[\u{1F600}-\u{1F64F}]|' // Emoticons
                    r'[\u{1F300}-\u{1F5FF}]|' // Misc Symbols and Pictographs
                    r'[\u{1F680}-\u{1F6FF}]|' // Transport and Map
                    r'[\u{2600}-\u{26FF}]|' // Misc symbols
                    r'[\u{2700}-\u{27BF}]|' // Dingbats
                    r'[\u{FE00}-\u{FE0F}]|' // Variation Selectors
                    r'[\u{1F900}-\u{1F9FF}]|' // Supplemental Symbols and Pictographs
                    r'[\u{1F1E6}-\u{1F1FF}]', // Flags
                    unicode: true,
                  ),
                ),
                if (inputFormatters != null) ...inputFormatters!,
              ],
              enabled: enabled,
              readOnly: readOnly,
              onChanged: onChanged,
              style: obscureText == true
                  ? f14w400ForPin()
                  : inputTextStyle ?? f14w400(),
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              cursorColor: cursorColor,
              cursorHeight: 25,
              maxLines: maxLines,
              buildCounter:
                  (
                    context, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) => (maxLength != null) && (showLetterCounter == true)
                  ? Text('$currentLength/$maxLength')
                  : null,
              decoration: InputDecoration(
                fillColor: backgroundColor,
                filled: true,
                prefixIcon: prefixIcon,
                contentPadding: contentPadding,
                labelText: labelText,
                hintText: hintText,
                hintStyle: f14w400(color: hintTextColor),
                errorText: errorText,
                suffixIcon: suffixIconAlwaysVisible && suffixIcon != null
                    ? GestureDetector(
                        onTap: onSuffixIconPressed,
                        child: suffixIcon,
                      )
                    : controller.text.isNotEmpty && suffixIcon != null
                    ? GestureDetector(
                        onTap: onSuffixIconPressed,
                        child: suffixIcon,
                      )
                    : null,
                enabledBorder:
                    enabledBorder ??
                    OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: defaultBorderColor,
                        width: 1,
                      ),
                    ),
                focusedBorder:
                    focusedBorder ??
                    OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: blueOriginal, width: 1),
                    ),
                disabledBorder:
                    disabledBorder ??
                    OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: defaultBorderColor,
                        width: 1,
                      ),
                    ),
                border:
                    border ??
                    OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        color: defaultBorderColor,
                        width: 1,
                      ),
                    ),
              ),
              obscureText: obscureText ?? false,
            ),
          ),
        ),
      ],
    );
  }
}
