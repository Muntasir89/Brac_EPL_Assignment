import 'package:branc_epl/core/error/failures.dart';
import 'package:branc_epl/core/usecase/usecase.dart';
import 'package:branc_epl/feature/home/domain/repository/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteTransaction implements UseCase<void, String> {
  final TransactionRepository transactionRepository;

  DeleteTransaction(this.transactionRepository);

  @override
  Future<Either<Failure, void>> call(String transactionId) async {
    return await transactionRepository.deleteTransaction(transactionId);
  }
}
