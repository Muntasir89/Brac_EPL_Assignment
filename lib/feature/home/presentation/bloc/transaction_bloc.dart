import 'package:bloc/bloc.dart';
import 'package:branc_epl/feature/home/domain/usecases/add_transaction.dart';
import 'package:branc_epl/feature/home/domain/usecases/delete_transaction.dart';
import 'package:branc_epl/feature/home/domain/usecases/get_transactions.dart';
import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions _getTransactions;
  final AddTransaction _addTransaction;
  final DeleteTransaction _deleteTransaction;

  TransactionBloc({
    required GetTransactions getTransactions,
    required AddTransaction addTransaction,
    required DeleteTransaction deleteTransaction,
  }) : _getTransactions = getTransactions,
       _addTransaction = addTransaction,
       _deleteTransaction = deleteTransaction,
       super(TransactionInitial()) {
    on<TransactionEvent>((_, emit) => emit(TransactionLoading()));
    on<TransactionGetAll>(_onGetAllTransactions);
    on<TransactionAdd>(_onAddTransaction);
    on<TransactionDelete>(_onDeleteTransaction);
  }

  void _onGetAllTransactions(
    TransactionGetAll event,
    Emitter<TransactionState> emit,
  ) async {
    final res = await _getTransactions(event.userId);

    res.fold(
      (l) => emit(TransactionFailure(l.message)),
      (transactions) => emit(TransactionSuccess(transactions)),
    );
  }

  void _onAddTransaction(
    TransactionAdd event,
    Emitter<TransactionState> emit,
  ) async {
    final res = await _addTransaction(
      AddTransactionParams(
        userId: event.userId,
        title: event.title,
        subtitle: event.subtitle,
        date: event.date,
        amount: event.amount,
        isDeposit: event.isDeposit,
      ),
    );

    res.fold((l) => emit(TransactionFailure(l.message)), (transaction) {
      emit(TransactionAddSuccess(transaction));
      // Refresh the transaction list
      add(TransactionGetAll(event.userId));
    });
  }

  void _onDeleteTransaction(
    TransactionDelete event,
    Emitter<TransactionState> emit,
  ) async {
    final res = await _deleteTransaction(event.transactionId);

    res.fold(
      (l) => emit(TransactionFailure(l.message)),
      (_) => emit(TransactionDeleteSuccess()),
    );
  }
}
