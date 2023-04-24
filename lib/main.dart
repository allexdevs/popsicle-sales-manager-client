// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:popsicle_sales_manager_client/pages/dashboard_page.dart';
import 'package:popsicle_sales_manager_client/pages/history_page.dart';
import 'package:popsicle_sales_manager_client/pages/qrcode_page.dart';
import 'package:popsicle_sales_manager_client/pages/settings_page.dart';
import 'package:popsicle_sales_manager_client/providers/balance_provider.dart';
import 'package:popsicle_sales_manager_client/providers/dashboard_provider.dart';
import 'package:popsicle_sales_manager_client/providers/history_provider.dart';
import 'package:popsicle_sales_manager_client/providers/new_sale_provider.dart';
import 'package:popsicle_sales_manager_client/providers/settings_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NewSaleProvider()),
      ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ChangeNotifierProvider(create: (_) => BalanceProvider()),
      ChangeNotifierProvider(create: (_) => HistoryProvider()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Colors.green.shade700,
              onPrimary: Colors.white,
              secondary: Colors.pink.shade400,
              onSecondary: Colors.white,
              error: Colors.red.shade500,
              onError: Colors.white,
              background: Colors.black38,
              onBackground: Colors.white,
              surface: Colors.white,
              onSurface: Colors.white)),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => DashboardPage(),
        '/settings': (context) => SettingsPage(),
        '/qrcode': (context) => const QrcodePage(),
        '/history': (context) => const HistoryPage()
      },
    );
  }
}
