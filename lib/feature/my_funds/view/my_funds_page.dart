import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/feature/my_funds/widget/fund_type_item.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/spacing.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:flutter/material.dart';

class MyFundsPage extends StatefulWidget {
  const MyFundsPage({super.key});

  @override
  State<MyFundsPage> createState() => _MyFundsPageState();
}

class _MyFundsPageState extends State<MyFundsPage> {
  String selectedPeriod = '1M';

  final List<String> periods = ['1M', '3M', '6M', '1Y', 'All'];

  // Dummy chart data points
  final List<double> chartData = [
    9298,
    9400,
    9200,
    9500,
    9300,
    9600,
    9400,
    9700,
    9500,
    9800,
    9600,
    9900,
    9700,
    9966,
    9800,
    9600,
    9700,
    9500,
    9800,
    9600,
    9900,
    9700,
    9800,
    9600,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: frameBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap.h16,
              // Title
              CommonTextWidget(
                text: 'My Funds',
                style: f20w600(color: black),
              ),
              Gap.h16,

              // Chart Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: DimenSizes.radius_16,
                  boxShadow: [
                    BoxShadow(
                      color: black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Chart Area
                    SizedBox(
                      height: 200,
                      child: CustomPaint(
                        size: Size(double.infinity, 200),
                        painter: LineChartPainter(chartData),
                      ),
                    ),
                    Gap.h20,

                    // Period Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: periods.map((period) {
                        final isSelected = selectedPeriod == period;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPeriod = period;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? blueOriginal
                                  : Colors.transparent,
                              borderRadius: DimenSizes.radius_50,
                            ),
                            child: CommonTextWidget(
                              text: period,
                              style: f14w600(
                                color: isSelected ? white : blackShade3,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              Gap.h24,

              // Fund Allocation Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: DimenSizes.radius_16,
                  boxShadow: [
                    BoxShadow(
                      color: black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      text: 'Fund Allocation',
                      style: f18w600(color: black),
                    ),
                    Gap.h20,
                    // Equity Funds
                    FundTypeItem(
                      color: blueOriginal,
                      title: 'Equity Funds',
                      amount: '\$4,770',
                      percentage: '45%',
                      progress: 0.45,
                    ),
                    Gap.h20,

                    // Bond Funds
                    FundTypeItem(
                      color: greenShade1,
                      title: 'Bond Funds',
                      amount: '\$3,180',
                      percentage: '30%',
                      progress: 0.30,
                    ),
                    Gap.h20,

                    // Money Market
                    FundTypeItem(
                      color: pendingColor,
                      title: 'Money Market',
                      amount: '\$1,590',
                      percentage: '15%',
                      progress: 0.15,
                    ),
                    Gap.h20,

                    // Alternative Investments
                    FundTypeItem(
                      color: rejectedColor,
                      title: 'Alternative Investments',
                      amount: '\$1,060',
                      percentage: '10%',
                      progress: 0.10,
                    ),
                    Gap.h32,

                    // Total Investment
                    Center(
                      child: Column(
                        children: [
                          CommonTextWidget(
                            text: 'Total Investment',
                            style: f14w400(color: blackShade3),
                          ),
                          Gap.h8,
                          CommonTextWidget(
                            text: '\$10,600',
                            style: f28w700(color: black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Gap.h80, // Space for bottom nav
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Chart Painter
class LineChartPainter extends CustomPainter {
  final List<double> data;

  LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = blueOriginal
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = blueOriginal.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    // Find min and max values for scaling
    final minValue = data.reduce((a, b) => a < b ? a : b);
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final range = maxValue - minValue;

    // Calculate points
    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final normalizedValue = (data[i] - minValue) / range;
      final y =
          size.height -
          (normalizedValue * size.height * 0.8) -
          (size.height * 0.1);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    // Complete fill path
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // Draw fill and line
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw value labels
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Max value label
    textPainter.text = TextSpan(
      text: '9966',
      style: TextStyle(
        color: blackShade3,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(0, 0));

    // Min value label
    textPainter.text = TextSpan(
      text: '9298',
      style: TextStyle(
        color: blackShade3,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(0, size.height - 15));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
