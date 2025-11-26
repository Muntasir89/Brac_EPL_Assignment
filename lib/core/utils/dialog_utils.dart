import 'package:branc_epl/core/common/widgets/common_primary_btn.dart';
import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:branc_epl/utils/dimens/dimensions.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void addTransactionDialog(
    BuildContext context, {
    final String? image,
    final String? title,
    final String? message,
    final bool isCloseButtonHidden = false,
    final bool isProceedButtonHidden = false,
    final String? closeText,
    final String? proceedText,
    final VoidCallback? onPressedClose,
    final VoidCallback? onPressedProceed,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              // height: MediaQuery.of(context),
              // padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 41,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (image != null) ...<Widget>[
                      Image.asset(image, height: 118, width: 118),
                      Gap.h14,
                    ],
                    if (title != null) ...<Widget>[
                      CommonTextWidget(
                        text: title,
                        textAlign: TextAlign.center,
                        style: f18w500(color: blackShade1),
                      ),
                      Gap.h14,
                    ],
                    if (message != null) ...<Widget>[
                      CommonTextWidget(
                        text: message,
                        textAlign: TextAlign.center,
                        style: f14w400(color: blackShade2),
                      ),
                      Gap.h36,
                    ],
                    // if (widget.commonDialogBox.isproceeding)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isCloseButtonHidden) ...<Widget>[
                          Expanded(
                            child: CommonPrimaryButton(
                              onPressed: () {
                                onPressedClose != null
                                    ? onPressedClose()
                                    : Navigator.pop(context);
                              },
                              title: closeText ?? "Close",
                              buttonColor: white,
                              borderColor: blackShade3,
                              textColor: blackShade3,
                              borderRadius: 5,
                            ),
                          ),
                          Gap.w14,
                        ],
                        if (!isProceedButtonHidden) ...<Widget>[
                          Expanded(
                            child: CommonPrimaryButton(
                              onPressed: () {
                                if (onPressedProceed != null) {
                                  onPressedProceed();
                                }
                                // Navigator.pop(context);
                              },
                              title: proceedText ?? "Proceed",
                              buttonColor: blueOriginal,
                              textColor: white,
                              borderRadius: 5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
