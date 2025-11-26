import 'package:branc_epl/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final String date;
  final double amount;
  final bool isDeposit;
  final String userId;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.isDeposit,
    required this.userId,
    required this.createdAt,
  });

  // Computed properties based on isDeposit
  IconData get icon => isDeposit ? Icons.arrow_downward : Icons.arrow_upward;

  Color get iconColor => isDeposit ? greenShade1 : rejectedColor;

  Color get iconBg =>
      isDeposit ? greenShade1.withOpacity(0.1) : rejectedColor.withOpacity(0.1);

  String get formattedAmount =>
      '${isDeposit ? '+' : '-'}৳${amount.toStringAsFixed(0)}';

  Color get amountColor => isDeposit ? greenShade1 : rejectedColor;

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'date': date,
      'amount': amount,
      'isDeposit': isDeposit,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from Firestore JSON
  factory TransactionModel.fromJson(Map<String, dynamic> json, String id) {
    return TransactionModel(
      id: id,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      date: json['date'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      isDeposit: json['isDeposit'] ?? true,
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // Copy with method
  TransactionModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? date,
    double? amount,
    bool? isDeposit,
    String? userId,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      isDeposit: isDeposit ?? this.isDeposit,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
