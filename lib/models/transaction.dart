enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String category;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.name,
      'category': category,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      type: TransactionType.values.firstWhere((e) => e.name == json['type']),
      category: json['category'],
    );
  }
}

// Mock Data
final List<Transaction> mockTransactions = [
  Transaction(
    id: 't1',
    title: 'Salary from Company',
    amount: 3200.00,
    date: DateTime.now().subtract(const Duration(days: 2)),
    type: TransactionType.income,
    category: 'Salary',
  ),
  Transaction(
    id: 't2',
    title: 'Grocery Supplies',
    amount: 145.50,
    date: DateTime.now().subtract(const Duration(hours: 12)),
    type: TransactionType.expense,
    category: 'Food',
  ),
  Transaction(
    id: 't3',
    title: 'Movie Tickets',
    amount: 35.00,
    date: DateTime.now().subtract(const Duration(days: 1)),
    type: TransactionType.expense,
    category: 'Entertainment',
  ),
  Transaction(
    id: 't4',
    title: 'Uber to Airport',
    amount: 54.20,
    date: DateTime.now().subtract(const Duration(days: 3)),
    type: TransactionType.expense,
    category: 'Transport',
  ),
  Transaction(
    id: 't5',
    title: 'Freelance Project',
    amount: 850.00,
    date: DateTime.now().subtract(const Duration(days: 4)),
    type: TransactionType.income,
    category: 'Side Hustle',
  ),
];
