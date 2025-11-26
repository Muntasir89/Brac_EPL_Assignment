part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionSuccess extends TransactionState {
  final List<TransactionModel> transactions;

  TransactionSuccess(this.transactions);
}

final class TransactionFailure extends TransactionState {
  final String message;

  TransactionFailure(this.message);
}

final class TransactionAddSuccess extends TransactionState {
  final TransactionModel transaction;

  TransactionAddSuccess(this.transaction);
}

final class TransactionDeleteSuccess extends TransactionState {}
