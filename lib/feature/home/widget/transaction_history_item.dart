import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:branc_epl/utils/dimens/dimensions.dart';
import 'package:flutter/material.dart';

class TransactionHistoryItem extends StatelessWidget {
  const TransactionHistoryItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.amountColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String date;
  final String amount;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          Gap.w16,
          // Title and Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  text: title,
                  style: f16w600(color: black),
                ),
                Gap.h4,
                CommonTextWidget(
                  text: subtitle,
                  style: f14w400(color: blackShade3),
                ),
                Gap.h2,
                CommonTextWidget(
                  text: date,
                  style: f12w400(color: blackShade4),
                ),
              ],
            ),
          ),
          // Amount
          CommonTextWidget(
            text: amount,
            style: f18w700(color: amountColor),
          ),
        ],
      ),
    );
  }
}
