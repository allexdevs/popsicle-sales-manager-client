// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class BalanceProvider with ChangeNotifier {
  double _totalBalance = 0;
  double get totalBalance => _totalBalance;

  double _pixBalance = 0;
  double get pixBalance => _pixBalance;

  double _balanceMoney = 0;
  double get balanceMoney => _balanceMoney;

  double _discountBalance = 0;
  double get discountBalance => _discountBalance;

  double _netBalance = 0;
  double get netBalance => _netBalance;

  void calculateTotalBalance() {
    _totalBalance = (_balanceMoney + _pixBalance);
    notifyListeners();
  }

  void calculateBalancePix(String paymentMethod, double value) {
    if (paymentMethod == 'Pix') {
      _pixBalance += value;
    }
    notifyListeners();
  }

  void calculateBalanceMoney(String paymentMethod, double value) {
    if (paymentMethod == 'Dinheiro') {
      _balanceMoney += value;
    }
    notifyListeners();
  }

  void calculateDiscountBalance(double value) {
    if (value > 0) {
      _discountBalance += value;
    }
    notifyListeners();
  }

  void calculateNetBalance() {
    _netBalance = (_balanceMoney + _pixBalance) - _discountBalance;
    notifyListeners();
  }
}
