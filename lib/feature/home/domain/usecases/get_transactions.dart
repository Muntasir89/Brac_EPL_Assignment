import 'package:branc_epl/core/error/failures.dart';
import 'package:branc_epl/core/usecase/usecase.dart';
import 'package:branc_epl/feature/home/domain/repository/transaction_repository.dart';
import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:fpdart/fpdart.dart';

class GetTransactions implements UseCase<List<TransactionModel>, String> {
  final TransactionRepository transactionRepository;

  GetTransactions(this.transactionRepository);

  @override
  Future<Either<Failure, List<TransactionModel>>> call(String userId) async {
    return await transactionRepository.getTransactions(userId);
  }
}
