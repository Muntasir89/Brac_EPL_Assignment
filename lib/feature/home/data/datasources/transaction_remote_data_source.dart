import 'package:branc_epl/feature/home/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions(String userId);

  Future<TransactionModel> addTransaction({
    required String userId,
    required String title,
    required String subtitle,
    required String date,
    required double amount,
    required bool isDeposit,
  });

  Future<void> deleteTransaction(String transactionId);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  TransactionRemoteDataSourceImpl(this.firebaseFirestore);

  @override
  Future<List<TransactionModel>> getTransactions(String userId) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .get();

      // Sort transactions by createdAt in descending order (newest first)
      final transactions = querySnapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data(), doc.id))
          .toList();

      transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return transactions;
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  @override
  Future<TransactionModel> addTransaction({
    required String userId,
    required String title,
    required String subtitle,
    required String date,
    required double amount,
    required bool isDeposit,
  }) async {
    try {
      final now = DateTime.now();
      final docRef = await firebaseFirestore.collection('transactions').add({
        'userId': userId,
        'title': title,
        'subtitle': subtitle,
        'date': date,
        'amount': amount,
        'isDeposit': isDeposit,
        'createdAt': now.toIso8601String(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Return the transaction with the current timestamp
      return TransactionModel(
        id: docRef.id,
        userId: userId,
        title: title,
        subtitle: subtitle,
        date: date,
        amount: amount,
        isDeposit: isDeposit,
        createdAt: now,
      );
    } catch (e) {
      throw Exception('Failed to add transaction: $e');
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      await firebaseFirestore
          .collection('transactions')
          .doc(transactionId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete transaction: $e');
    }
  }
}
