import 'package:branc_epl/core/error/failures.dart';
import 'package:branc_epl/feature/home/models/balance_model.dart';
import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, List<TransactionModel>>> getTransactions(
    String userId,
  );

  Future<Either<Failure, BalanceModel>> getBalance(String userId);

  Future<Either<Failure, TransactionModel>> addTransaction({
    required String userId,
    required String title,
    required String subtitle,
    required String date,
    required double amount,
    required bool isDeposit,
  });

  Future<Either<Failure, void>> deleteTransaction(String transactionId);
}
