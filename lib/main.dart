import 'package:flutter/material.dart';
import 'package:wallet_wise/theme/app_theme.dart';
import 'package:wallet_wise/screens/welcome_screen.dart';
import 'package:wallet_wise/screens/main_layout.dart';
import 'package:wallet_wise/services/finance_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FinanceService().init();
  runApp(const WalletWiseApp());
}

class WalletWiseApp extends StatelessWidget {
  const WalletWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletWise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.glassTheme,
      home: FinanceService().isLoggedIn ? const MainLayout() : const WelcomeScreen(),
    );
  }
}
