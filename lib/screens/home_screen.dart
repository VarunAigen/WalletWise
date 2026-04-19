import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_wise/theme/app_theme.dart';
import 'package:wallet_wise/widgets/glass_container.dart';
import 'package:wallet_wise/services/finance_service.dart';
import 'package:wallet_wise/models/transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FinanceService();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: AppTheme.mainGradient,
          child: ListenableBuilder(
            listenable: service,
            builder: (context, _) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildHeader(service),
                      const SizedBox(height: 32),
                      _buildBalanceCard(service),
                      const SizedBox(height: 32),
                      _buildRecentTransactionsHeader(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _buildTransactionList(service),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(FinanceService service) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16),
            ),
            Text(
              service.currentUser ?? 'User',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const GlassContainer(
          borderRadius: 16,
          padding: EdgeInsets.all(4),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a'),
            radius: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard(FinanceService service) {
    return GlassContainer(
      borderRadius: 32,
      padding: const EdgeInsets.all(32),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.primaryColor.withOpacity(0.2),
          AppTheme.secondaryColor.withOpacity(0.1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${service.totalBalance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem(
                Icons.arrow_downward,
                'Income',
                service.totalIncome,
                AppTheme.incomeColor,
              ),
              _buildSummaryItem(
                Icons.arrow_upward,
                'Expense',
                service.totalExpense,
                AppTheme.expenseColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String title, double amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '\$${amount.toStringAsFixed(0)}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactionsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Transactions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          'See All',
          style: TextStyle(color: AppTheme.primaryColor.withOpacity(0.8), fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTransactionList(FinanceService service) {
    final transactions = service.transactions.toList();
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No transactions yet',
          style: TextStyle(color: Colors.white.withOpacity(0.3)),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: transactions.length > 5 ? 5 : transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final isIncome = tx.type == TransactionType.income;
        return GlassContainer(
          height: 80,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: 20,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isIncome ? AppTheme.incomeColor : AppTheme.expenseColor).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  isIncome ? Icons.account_balance_wallet_rounded : Icons.shopping_cart_rounded,
                  color: isIncome ? AppTheme.incomeColor : AppTheme.expenseColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      tx.category,
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13),
                    ),
                  ],
                ),
              ),
              Text(
                '${isIncome ? '+' : '-'}\$${tx.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isIncome ? AppTheme.incomeColor : AppTheme.expenseColor,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
