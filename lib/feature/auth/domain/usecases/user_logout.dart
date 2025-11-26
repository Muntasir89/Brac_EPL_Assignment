import 'package:branc_epl/core/error/failures.dart';
import 'package:branc_epl/core/usecase/usecase.dart';
import 'package:branc_epl/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogout implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  const UserLogout(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
