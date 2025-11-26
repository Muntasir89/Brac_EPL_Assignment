part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

final class TransactionGetAll extends TransactionEvent {
  final String userId;

  TransactionGetAll(this.userId);
}

final class TransactionAdd extends TransactionEvent {
  final String userId;
  final String title;
  final String subtitle;
  final String date;
  final double amount;
  final bool isDeposit;

  TransactionAdd({
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.isDeposit,
  });
}

final class TransactionDelete extends TransactionEvent {
  final String transactionId;

  TransactionDelete(this.transactionId);
}

final class TransactionGetBalance extends TransactionEvent {
  final String userId;

  TransactionGetBalance(this.userId);
}
