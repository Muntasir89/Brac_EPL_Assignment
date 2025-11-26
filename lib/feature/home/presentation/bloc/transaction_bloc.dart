import 'package:bloc/bloc.dart';
import 'package:branc_epl/feature/home/domain/usecases/add_transaction.dart';
import 'package:branc_epl/feature/home/domain/usecases/delete_transaction.dart';
import 'package:branc_epl/feature/home/domain/usecases/get_balance.dart';
import 'package:branc_epl/feature/home/domain/usecases/get_transactions.dart';
import 'package:branc_epl/feature/home/models/balance_model.dart';
import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions _getTransactions;
  final AddTransaction _addTransaction;
  final DeleteTransaction _deleteTransaction;
  final GetBalance _getBalance;

  TransactionBloc({
    required GetTransactions getTransactions,
    required AddTransaction addTransaction,
    required DeleteTransaction deleteTransaction,
    required GetBalance getBalance,
  }) : _getTransactions = getTransactions,
       _addTransaction = addTransaction,
       _deleteTransaction = deleteTransaction,
       _getBalance = getBalance,
       super(TransactionInitial()) {
    on<TransactionEvent>((_, emit) => emit(TransactionLoading()));
    on<TransactionGetAll>(_onGetAllTransactions);
    on<TransactionAdd>(_onAddTransaction);
    on<TransactionDelete>(_onDeleteTransaction);
    on<TransactionGetBalance>(_onGetBalance);
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
      // Refresh the transaction list and balance
      add(TransactionGetAll(event.userId));
      add(TransactionGetBalance(event.userId));
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

  void _onGetBalance(
    TransactionGetBalance event,
    Emitter<TransactionState> emit,
  ) async {
    final res = await _getBalance(event.userId);

    res.fold(
      (l) => emit(TransactionFailure(l.message)),
      (balance) => emit(TransactionBalanceSuccess(balance)),
    );
  }
}
