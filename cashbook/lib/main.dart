import 'package:cashbook/routes/routes.dart';
import 'package:cashbook/screens/expanse_screen.dart';
import 'package:cashbook/screens/history_screen.dart';
import 'package:cashbook/screens/home_screen.dart';
import 'package:cashbook/screens/income_screen.dart';
import 'package:cashbook/screens/login_screen.dart';
import 'package:cashbook/screens/setting_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      title: 'CashFlow App',
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        Routes.homeScreen: (context) => const HomeScreen(),
        Routes.loginScreen: (context) => const LoginScreen(),
        Routes.incomeScreen: (context) => const IncomeScreen(),
        Routes.expenseScreen: (context) => const ExpanseScreen(),
        Routes.historyScreen:(context) => const HistoryScreen(),
        Routes.settingScreen:(context) => const SettingScreen(),
      },
    );
  }
}
