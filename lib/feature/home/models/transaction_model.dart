import 'package:flutter/material.dart';

class TransactionModel {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String date;
  final String amount;
  final Color amountColor;

  TransactionModel({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.amountColor,
  });
}
