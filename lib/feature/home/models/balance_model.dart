class BalanceModel {
  final double currentBalance;
  final double availableBalance;

  BalanceModel({required this.currentBalance, required this.availableBalance});

  factory BalanceModel.fromTransactions(List<dynamic> transactions) {
    double totalDeposits = 0.0;
    double totalWithdrawals = 0.0;

    for (var transaction in transactions) {
      if (transaction is Map<String, dynamic>) {
        final amount = (transaction['amount'] ?? 0).toDouble();
        final isDeposit = transaction['isDeposit'] ?? false;

        if (isDeposit) {
          totalDeposits += amount;
        } else {
          totalWithdrawals += amount;
        }
      }
    }

    final currentBalance = totalDeposits - totalWithdrawals;
    // Available balance could have business logic (e.g., reserved funds)
    // For now, we'll assume 80% is available
    final availableBalance = currentBalance * 0.8;

    return BalanceModel(
      currentBalance: currentBalance,
      availableBalance: availableBalance,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentBalance': currentBalance,
      'availableBalance': availableBalance,
    };
  }

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      currentBalance: (json['currentBalance'] ?? 0).toDouble(),
      availableBalance: (json['availableBalance'] ?? 0).toDouble(),
    );
  }

  BalanceModel copyWith({double? currentBalance, double? availableBalance}) {
    return BalanceModel(
      currentBalance: currentBalance ?? this.currentBalance,
      availableBalance: availableBalance ?? this.availableBalance,
    );
  }
}
