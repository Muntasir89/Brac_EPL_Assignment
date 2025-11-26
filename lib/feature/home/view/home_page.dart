import 'package:branc_epl/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/feature/home/presentation/bloc/transaction_bloc.dart';
import 'package:branc_epl/feature/home/widget/add_transaction_dialog.dart';
import 'package:branc_epl/feature/home/widget/transaction_history_item.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:branc_epl/utils/dimens/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch transactions when page loads
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<TransactionBloc>().add(TransactionGetAll(userId));
  }

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
                    if (state.transactions.isEmpty) {
                      return Center(
                        child: CommonTextWidget(
                          text: 'No transactions yet',
                          style: f14w400(color: blackShade3),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.transactions.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.transactions.length) {
                          return const SizedBox(height: 80);
                        }
                        final transaction = state.transactions[index];
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
                  return const SizedBox.shrink();
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
