import 'package:branc_epl/core/error/exceptions.dart';
import 'package:branc_epl/core/error/failures.dart';
import 'package:branc_epl/feature/home/data/datasources/transaction_remote_data_source.dart';
import 'package:branc_epl/feature/home/domain/repository/transaction_repository.dart';
import 'package:branc_epl/feature/home/models/balance_model.dart';
import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:fpdart/fpdart.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource transactionRemoteDataSource;

  TransactionRepositoryImpl(this.transactionRemoteDataSource);

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions(
    String userId,
  ) async {
    try {
      final transactions = await transactionRemoteDataSource.getTransactions(
        userId,
      );
      return right(transactions);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BalanceModel>> getBalance(String userId) async {
    try {
      final balance = await transactionRemoteDataSource.getBalance(userId);
      return right(balance);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TransactionModel>> addTransaction({
    required String userId,
    required String title,
    required String subtitle,
    required String date,
    required double amount,
    required bool isDeposit,
  }) async {
    try {
      final transaction = await transactionRemoteDataSource.addTransaction(
        userId: userId,
        title: title,
        subtitle: subtitle,
        date: date,
        amount: amount,
        isDeposit: isDeposit,
      );
      return right(transaction);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String transactionId) async {
    try {
      await transactionRemoteDataSource.deleteTransaction(transactionId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
