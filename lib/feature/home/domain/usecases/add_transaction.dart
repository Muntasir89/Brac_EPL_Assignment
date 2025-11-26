import 'package:branc_epl/core/error/failures.dart';
import 'package:branc_epl/core/usecase/usecase.dart';
import 'package:branc_epl/feature/home/domain/repository/transaction_repository.dart';
import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:fpdart/fpdart.dart';

class AddTransactionParams {
  final String userId;
  final String title;
  final String subtitle;
  final String date;
  final double amount;
  final bool isDeposit;

  AddTransactionParams({
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.isDeposit,
  });
}

class AddTransaction
    implements UseCase<TransactionModel, AddTransactionParams> {
  final TransactionRepository transactionRepository;

  AddTransaction(this.transactionRepository);

  @override
  Future<Either<Failure, TransactionModel>> call(
    AddTransactionParams params,
  ) async {
    return await transactionRepository.addTransaction(
      userId: params.userId,
      title: params.title,
      subtitle: params.subtitle,
      date: params.date,
      amount: params.amount,
      isDeposit: params.isDeposit,
    );
  }
}
