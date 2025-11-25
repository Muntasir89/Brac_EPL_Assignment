import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:branc_epl/utils/dimens/dimensions.dart';
import 'package:flutter/material.dart';

class FundTypeItem extends StatelessWidget {
  const FundTypeItem({
    super.key,
    required this.color,
    required this.title,
    required this.amount,
    required this.percentage,
    required this.progress,
  });

  final Color color;
  final String title;
  final String amount;
  final String percentage;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            Gap.w8,
            Expanded(
              child: CommonTextWidget(
                text: title,
                style: f16w600(color: black),
              ),
            ),
            CommonTextWidget(
              text: percentage,
              style: f18w700(color: black),
            ),
          ],
        ),
        Gap.h8,
        CommonTextWidget(
          text: amount,
          style: f14w400(color: blackShade3),
        ),
        Gap.h8,
        ClipRRect(
          borderRadius: DimenSizes.radius_50,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: blackShade5,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
