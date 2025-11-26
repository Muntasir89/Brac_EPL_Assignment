import 'package:branc_epl/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:branc_epl/core/common/widgets/common_input_field.dart';
import 'package:branc_epl/core/common/widgets/common_primary_btn.dart';
import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/feature/home/presentation/bloc/transaction_bloc.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:branc_epl/utils/dimens/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  bool _isDeposit = true; // Default to deposit
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Set default date to today
    _dateController.text = DateFormat('MMM dd, yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: blueOriginal,
              onPrimary: white,
              onSurface: black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('MMM dd, yyyy').format(picked);
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final userId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;

      context.read<TransactionBloc>().add(
        TransactionAdd(
          userId: userId,
          title: _titleController.text.trim(),
          subtitle: _subtitleController.text.trim(),
          date: _dateController.text,
          amount: double.parse(_amountController.text.trim()),
          isDeposit: _isDeposit,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionAddSuccess) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CommonTextWidget(
                text: 'Transaction added successfully',
                style: f14w400(color: white),
              ),
              backgroundColor: greenShade1,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is TransactionFailure) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CommonTextWidget(
                text: state.message,
                style: f14w400(color: white),
              ),
              backgroundColor: rejectedColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget(
                          text: 'Add Transaction',
                          style: f20w600(color: black),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: blackShade3),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    Gap.h20,

                    // Transaction Type Toggle
                    CommonTextWidget(
                      text: 'Transaction Type',
                      style: f14w500(color: black),
                    ),
                    Gap.h12,
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isDeposit = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _isDeposit
                                    ? greenShade1.withOpacity(0.1)
                                    : white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _isDeposit ? greenShade1 : blackShade5,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: _isDeposit
                                        ? greenShade1
                                        : blackShade3,
                                    size: 20,
                                  ),
                                  Gap.w8,
                                  CommonTextWidget(
                                    text: 'Deposit',
                                    style: f14w600(
                                      color: _isDeposit
                                          ? greenShade1
                                          : blackShade3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Gap.w12,
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isDeposit = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: !_isDeposit
                                    ? rejectedColor.withOpacity(0.1)
                                    : white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: !_isDeposit
                                      ? rejectedColor
                                      : blackShade5,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    color: !_isDeposit
                                        ? rejectedColor
                                        : blackShade3,
                                    size: 20,
                                  ),
                                  Gap.w8,
                                  CommonTextWidget(
                                    text: 'Withdraw',
                                    style: f14w600(
                                      color: !_isDeposit
                                          ? rejectedColor
                                          : blackShade3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap.h20,

                    // Title Field
                    CommonInputField(
                      controller: _titleController,
                      hintText: 'e.g., Salary, Shopping',
                      title: 'Title',
                      titleStyle: f14w500(color: black),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    Gap.h16,

                    // Subtitle Field
                    CommonInputField(
                      controller: _subtitleController,
                      hintText: 'e.g., Monthly income, Emergency',
                      title: 'Description',
                      titleStyle: f14w500(color: black),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    Gap.h16,

                    // Amount Field
                    CommonInputField(
                      controller: _amountController,
                      hintText: '0.00',
                      title: 'Amount (৳)',
                      titleStyle: f14w500(color: black),
                      inputType: TextInputType.number,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: CommonTextWidget(
                          text: '৳',
                          style: f16w600(color: blackShade3),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter an amount';
                        }
                        final amount = double.tryParse(value.trim());
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    Gap.h16,

                    // Date Field
                    CommonInputField(
                      controller: _dateController,
                      hintText: 'Select date',
                      title: 'Date',
                      titleStyle: f14w500(color: black),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: blueOriginal,
                        size: 20,
                      ),
                      suffixIconAlwaysVisible: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                    Gap.h24,

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: CommonPrimaryButton(
                            onPressed: () => Navigator.pop(context),
                            title: 'Cancel',
                            buttonColor: white,
                            borderColor: blackShade3,
                            textColor: blackShade3,
                            borderRadius: 8,
                          ),
                        ),
                        Gap.w12,
                        Expanded(
                          child: CommonPrimaryButton(
                            onPressed: _isLoading ? null : _handleSubmit,
                            title: _isLoading ? 'Adding...' : 'Add',
                            buttonColor: blueOriginal,
                            textColor: white,
                            borderRadius: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
