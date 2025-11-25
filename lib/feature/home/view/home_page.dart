import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:branc_epl/feature/home/widget/recent_transaction_item.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:branc_epl/utils/dimens/dimensions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Dummy transaction data
  static final List<TransactionModel> transactions = [
    TransactionModel(
      icon: Icons.arrow_downward,
      iconColor: greenShade1,
      iconBg: greenShade1.withOpacity(0.1),
      title: 'Deposit',
      subtitle: 'Monthly savings',
      date: 'Yesterday',
      amount: '+৳500',
      amountColor: greenShade1,
    ),
    TransactionModel(
      icon: Icons.arrow_upward,
      iconColor: rejectedColor,
      iconBg: rejectedBackgroundColor,
      title: 'Withdraw',
      subtitle: 'Emergency fund',
      date: 'Nov 22',
      amount: '-৳200',
      amountColor: rejectedColor,
    ),
    TransactionModel(
      icon: Icons.arrow_downward,
      iconColor: greenShade1,
      iconBg: greenShade1.withOpacity(0.1),
      title: 'Deposit',
      subtitle: 'Salary deposit',
      date: 'Nov 20',
      amount: '+৳1,000',
      amountColor: greenShade1,
    ),
    TransactionModel(
      icon: Icons.swap_horiz,
      iconColor: pendingColor,
      iconBg: pendingBackgroundColor,
      title: 'Transfer',
      subtitle: 'Investment rebalancing',
      date: 'Nov 18',
      amount: '৳300',
      amountColor: black,
    ),
    TransactionModel(
      icon: Icons.arrow_downward,
      iconColor: greenShade1,
      iconBg: greenShade1.withOpacity(0.1),
      title: 'Deposit',
      subtitle: 'Nov 15',
      date: 'Nov 15',
      amount: '+৳750',
      amountColor: greenShade1,
    ),
    TransactionModel(
      icon: Icons.arrow_upward,
      iconColor: rejectedColor,
      iconBg: rejectedBackgroundColor,
      title: 'Withdraw',
      subtitle: 'Personal expense',
      date: 'Nov 13',
      amount: '-৳150',
      amountColor: rejectedColor,
    ),
    TransactionModel(
      icon: Icons.arrow_downward,
      iconColor: greenShade1,
      iconBg: greenShade1.withOpacity(0.1),
      title: 'Deposit',
      subtitle: 'Bonus payment',
      date: 'Nov 10',
      amount: '+৳2,000',
      amountColor: greenShade1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: frameBg,
      body: SafeArea(
        child: Column(
          children: [
            CommonTextWidget(
              text: 'Home',
              style: f20w600(color: black),
            ),
            // Balance Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Balance Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          text: 'Current Balance',
                          style: f14w400(color: blackShade3),
                        ),
                        const SizedBox(height: 8),
                        CommonTextWidget(
                          text: '৳10,600',
                          style: f28w700(color: black),
                        ),
                      ],
                    ),
                  ),
                  Gap.w16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          text: 'Available',
                          style: f14w400(color: blackShade3),
                        ),
                        const SizedBox(height: 8),
                        CommonTextWidget(
                          text: '৳8,500',
                          style: f28w700(color: greenShade1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Recent Transactions Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CommonTextWidget(
                  text: 'Recent Transactions',
                  style: f18w600(color: black),
                ),
              ),
            ),

            // Transaction List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: transactions.length + 1, // +1 for bottom spacing
                itemBuilder: (context, index) {
                  if (index == transactions.length) {
                    return const SizedBox(height: 80); // Space for bottom nav
                  }
                  final transaction = transactions[index];
                  return RecentTransactionItem(
                    icon: transaction.icon,
                    iconColor: transaction.iconColor,
                    iconBg: transaction.iconBg,
                    title: transaction.title,
                    subtitle: transaction.subtitle,
                    date: transaction.date,
                    amount: transaction.amount,
                    amountColor: transaction.amountColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: blueOriginal,
        child: const Icon(Icons.add, color: white, size: 32),
      ),
    );
  }
}
