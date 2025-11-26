import 'package:branc_epl/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:branc_epl/feature/home/presentation/bloc/transaction_bloc.dart';
import 'package:branc_epl/feature/home/widget/add_transaction_dialog.dart';
import 'package:branc_epl/feature/home/widget/transaction_history_item.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/spacing.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  String selectedFilter = 'All';

  final List<String> filters = ['All', 'Deposit', 'Withdraw'];

  @override
  void initState() {
    super.initState();
    // Fetch transactions when page loads
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<TransactionBloc>().add(TransactionGetAll(userId));
  }

  List<TransactionModel> getFilteredTransactions(
    List<TransactionModel> allTransactions,
  ) {
    if (selectedFilter == 'All') {
      return allTransactions;
    } else if (selectedFilter == 'Deposit') {
      return allTransactions.where((t) => t.isDeposit).toList();
    } else if (selectedFilter == 'Withdraw') {
      return allTransactions.where((t) => !t.isDeposit).toList();
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
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: blueOriginal),
                    );
                  }

                  if (state is TransactionFailure) {
                    return Center(
                      child: CommonTextWidget(
                        text: state.message,
                        style: f14w400(color: rejectedColor),
                      ),
                    );
                  }

                  if (state is TransactionSuccess) {
                    final filteredTransactions = getFilteredTransactions(
                      state.transactions,
                    );

                    if (filteredTransactions.isEmpty) {
                      return Center(
                        child: CommonTextWidget(
                          text: 'No transactions found',
                          style: f16w400(color: blackShade3),
                        ),
                      );
                    }

                    return ListView.builder(
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
                          amount: transaction.formattedAmount,
                          amountColor: transaction.amountColor,
                        );
                      },
                    );
                  }

                  return Center(
                    child: CommonTextWidget(
                      text: 'No transactions yet',
                      style: f16w400(color: blackShade3),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTransactionDialog(),
          );
        },
        backgroundColor: blueOriginal,
        child: const Icon(Icons.add, color: white, size: 32),
      ),
    );
  }
}
