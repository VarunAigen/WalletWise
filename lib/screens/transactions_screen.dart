import 'package:flutter/material.dart';
import 'package:wallet_wise/theme/app_theme.dart';
import 'package:wallet_wise/widgets/glass_container.dart';
import 'package:wallet_wise/services/finance_service.dart';
import 'package:wallet_wise/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FinanceService();

    return Scaffold(
      body: Container(
        decoration: AppTheme.mainGradient,
        height: double.infinity,
        child: ListenableBuilder(
          listenable: service,
          builder: (context, _) {
            final transactions = service.transactions;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'History',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      'Track every penny',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: transactions.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 100),
                              itemCount: transactions.length,
                              itemBuilder: (context, index) {
                                final tx = transactions[index];
                                final isIncome = tx.type == TransactionType.income;
                                
                                // Show date header if date changes
                                bool showHeader = index == 0 || 
                                    DateFormat('MMMM dd').format(transactions[index].date) != 
                                    DateFormat('MMMM dd').format(transactions[index-1].date);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (showHeader)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 24, bottom: 12),
                                        child: Text(
                                          DateFormat('MMMM dd, yyyy').format(tx.date),
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.4),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    _buildTransactionTile(tx, isIncome),
                                  ],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 16),
          Text(
            'No transactions yet',
            style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(Transaction tx, bool isIncome) {
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 20,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (isIncome ? AppTheme.incomeColor : AppTheme.expenseColor).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isIncome ? Icons.account_balance_wallet_rounded : Icons.shopping_cart_rounded,
              color: isIncome ? AppTheme.incomeColor : AppTheme.expenseColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                Text(
                  tx.category,
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}\$${tx.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: isIncome ? AppTheme.incomeColor : AppTheme.expenseColor,
            ),
          )
        ],
      ),
    );
  }
}
