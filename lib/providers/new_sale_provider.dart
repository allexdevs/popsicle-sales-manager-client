// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';

class NewSaleProvider with ChangeNotifier {
  int _amount = 0;
  int get amount => _amount;

  double _discount = 0;
  double get discount => _discount;

  double _totalBalance = 0;
  double get totalBalance => _totalBalance;

  double _totalBalanceWithDiscount = 0;
  double get totalBalanceWithDiscount => _totalBalance - _discount;

  String _paymentMethod = 'Dinheiro';
  String get paymentMethod => _paymentMethod;

  void increment() {
    _amount++;
    notifyListeners();
  }

  void decrement() {
    _amount > 0 ? _amount-- : _amount = 0;
    notifyListeners();
  }

  void changeDiscount(value) {
    if (value.toString().isNotEmpty) {
      double convertedValue = double.parse(value);
      _discount = convertedValue;
    } else {
      _discount = 0;
    }
    notifyListeners();
  }

  void calculateTotalBalance() {
    if (_amount > 0) {
      _totalBalance = 2.0 * _amount;
    } else {
      _totalBalance = 0;
    }
    notifyListeners();
  }

  void changePaymentMethod(value) {
    _paymentMethod = value;
    notifyListeners();
    print(paymentMethod);
  }

  void clearAmount() => _amount = 0;

  void clearDiscount() => _discount = 0;

  void clearTotalBalance() => _totalBalance = 0;

  void clearPaymentMethod() => _paymentMethod = 'Dinheiro';
}
