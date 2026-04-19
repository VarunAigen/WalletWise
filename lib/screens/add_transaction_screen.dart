import 'package:flutter/material.dart';
import 'package:wallet_wise/theme/app_theme.dart';
import 'package:wallet_wise/widgets/glass_container.dart';
import 'package:wallet_wise/services/finance_service.dart';
import 'package:wallet_wise/models/transaction.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _isIncome = false;
  String _selectedCategory = 'Food';
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();

  final List<String> _expenseCategories = ['Food', 'Transport', 'Entertainment', 'Shopping'];
  final List<String> _incomeCategories = ['Salary', 'Freelance', 'Investment'];

  void _saveTransaction() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount <= 0 || _titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid details')),
      );
      return;
    }

    final tx = Transaction(
      id: DateTime.now().toString(),
      title: _titleController.text,
      amount: amount,
      date: DateTime.now(),
      type: _isIncome ? TransactionType.income : TransactionType.expense,
      category: _selectedCategory,
    );

    FinanceService().addTransaction(tx);
    
    _amountController.clear();
    _titleController.clear();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaction Saved Successfully!'),
        backgroundColor: AppTheme.incomeColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = _isIncome ? _incomeCategories : _expenseCategories;
    if (!categories.contains(_selectedCategory)) {
      _selectedCategory = categories.first;
    }

    return Scaffold(
      body: Container(
        decoration: AppTheme.mainGradient,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Add New',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'Keep your wallet wise',
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
                const SizedBox(height: 32),
                _buildToggleButton(),
                const SizedBox(height: 32),
                _buildFormSection(categories),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveTransaction,
                    child: const Text('Save Transaction'),
                  ),
                ),
                const SizedBox(height: 100), // Space for bottom nav
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    return GlassContainer(
      padding: const EdgeInsets.all(4),
      borderRadius: 16,
      child: Row(
        children: [
          Expanded(
            child: _toggleItem('Expense', !_isIncome, AppTheme.expenseColor),
          ),
          Expanded(
            child: _toggleItem('Income', _isIncome, AppTheme.incomeColor),
          ),
        ],
      ),
    );
  }

  Widget _toggleItem(String label, bool isSelected, Color color) {
    return GestureDetector(
      onTap: () => setState(() => _isIncome = label == 'Income'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.8) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(List<String> categories) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: 32,
      child: Column(
        children: [
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            decoration: const InputDecoration(
              prefixText: '\$ ',
              labelText: 'Amount',
              fillColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Description',
              prefixIcon: Icon(Icons.description_outlined),
              fillColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            dropdownColor: AppTheme.surfaceColor,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Category',
              prefixIcon: Icon(Icons.category_outlined),
              fillColor: Colors.transparent,
            ),
            items: categories.map((cat) {
              return DropdownMenuItem(
                value: cat,
                child: Text(cat, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedCategory = val);
            },
          ),
        ],
      ),
    );
  }
}
