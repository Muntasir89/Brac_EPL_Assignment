import 'package:branc_epl/core/error/failures.dart';
import 'package:branc_epl/core/usecase/usecase.dart';
import 'package:branc_epl/feature/home/domain/repository/transaction_repository.dart';
import 'package:branc_epl/feature/home/models/balance_model.dart';
import 'package:fpdart/fpdart.dart';

class GetBalance implements UseCase<BalanceModel, String> {
  final TransactionRepository transactionRepository;

  GetBalance(this.transactionRepository);

  @override
  Future<Either<Failure, BalanceModel>> call(String userId) async {
    return await transactionRepository.getBalance(userId);
  }
}
