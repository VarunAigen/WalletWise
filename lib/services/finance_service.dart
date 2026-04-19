import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_wise/models/transaction.dart';

class FinanceService extends ChangeNotifier {
  static final FinanceService _instance = FinanceService._internal();
  factory FinanceService() => _instance;
  FinanceService._internal();

  SharedPreferences? _prefs;

  // Auth State
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  
  String? _currentUser;
  String? get currentUser => _currentUser;

  // Data State
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => List.unmodifiable(_transactions);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Load auth state
    _isLoggedIn = _prefs?.getBool('isLoggedIn') ?? false;
    _currentUser = _prefs?.getString('currentUser');

    // Load transactions
    final txString = _prefs?.getString('transactions');
    if (txString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(txString);
        _transactions = decoded.map((e) => Transaction.fromJson(e)).toList();
      } catch (e) {
        // Fallback or error handling
      }
    }
    notifyListeners();
  }

  void _saveTransactions() {
    if (_prefs != null) {
      final String encoded = jsonEncode(_transactions.map((tx) => tx.toJson()).toList());
      _prefs!.setString('transactions', encoded);
    }
  }

  double get totalBalance {
    double balance = 0;
    for (var tx in _transactions) {
      if (tx.type == TransactionType.income) {
        balance += tx.amount;
      } else {
        balance -= tx.amount;
      }
    }
    return balance;
  }

  double get totalIncome {
    return _transactions
        .where((tx) => tx.type == TransactionType.income)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return _transactions
        .where((tx) => tx.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  // Auth Actions
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    _isLoggedIn = true;
    _currentUser = email.split('@')[0];
    
    if (_prefs != null) {
      await _prefs!.setBool('isLoggedIn', true);
      await _prefs!.setString('currentUser', _currentUser!);
    }
    
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _currentUser = null;
    
    if (_prefs != null) {
      await _prefs!.remove('isLoggedIn');
      await _prefs!.remove('currentUser');
    }
    
    notifyListeners();
  }

  // Transaction Actions
  void addTransaction(Transaction tx) {
    _transactions.insert(0, tx);
    _saveTransactions();
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    _saveTransactions();
    notifyListeners();
  }
}
