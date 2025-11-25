import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:branc_epl/feature/home/widget/transaction_history_item.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/spacing.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String selectedFilter = 'All';

  final List<String> filters = ['All', 'Deposit', 'Withdraw'];

  // All transactions
  final List<TransactionModel> allTransactions = [
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
      date: 'Nov 23',
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
      icon: Icons.arrow_upward,
      iconColor: rejectedColor,
      iconBg: rejectedBackgroundColor,
      title: 'Withdraw',
      subtitle: 'Personal expense',
      date: 'Nov 14',
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
    TransactionModel(
      icon: Icons.arrow_upward,
      iconColor: rejectedColor,
      iconBg: rejectedBackgroundColor,
      title: 'Withdraw',
      subtitle: 'Shopping',
      date: 'Nov 08',
      amount: '-৳350',
      amountColor: rejectedColor,
    ),
    TransactionModel(
      icon: Icons.arrow_downward,
      iconColor: greenShade1,
      iconBg: greenShade1.withOpacity(0.1),
      title: 'Deposit',
      subtitle: 'Freelance income',
      date: 'Nov 05',
      amount: '+৳800',
      amountColor: greenShade1,
    ),
  ];

  List<TransactionModel> get filteredTransactions {
    if (selectedFilter == 'All') {
      return allTransactions;
    } else if (selectedFilter == 'Deposit') {
      return allTransactions.where((t) => t.title == 'Deposit').toList();
    } else if (selectedFilter == 'Withdraw') {
      return allTransactions.where((t) => t.title == 'Withdraw').toList();
    }
    return allTransactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: frameBg,
      body: SafeArea(
        child: Column(
          children: [
            Gap.h16,
            // Title
            CommonTextWidget(
              text: 'Transaction History',
              style: f20w600(color: black),
            ),
            Gap.h20,

            // Filter Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    text: 'Filter by type:',
                    style: f14w400(color: blackShade3),
                  ),
                  Gap.h12,

                  // Filter Chips
                  Row(
                    children: filters.map((filter) {
                      final isSelected = selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? blueOriginal : white,
                              borderRadius: DimenSizes.radius_50,
                              border: Border.all(
                                color: isSelected ? blueOriginal : blackShade5,
                                width: 1,
                              ),
                            ),
                            child: CommonTextWidget(
                              text: filter,
                              style: f14w600(color: isSelected ? white : black),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            Gap.h20,

            // Transaction List
            Expanded(
              child: filteredTransactions.isEmpty
                  ? Center(
                      child: CommonTextWidget(
                        text: 'No transactions found',
                        style: f16w400(color: blackShade3),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredTransactions.length + 1,
                      itemBuilder: (context, index) {
                        if (index == filteredTransactions.length) {
                          return Gap.h80; // Space for bottom nav
                        }

                        final transaction = filteredTransactions[index];
                        return TransactionHistoryItem(
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
    );
  }
}
