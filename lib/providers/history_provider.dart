// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:popsicle_sales_manager_client/models/sale_model.dart';

class HistoryProvider with ChangeNotifier {
  final List<SaleModel> _salesHistory = [];
  List<SaleModel> get salesHistory => _salesHistory;

  double _totalBalance = 0.0;
  double get totalBalance => _totalBalance;

  double _totalBalanceMoney = 0.0;
  double get totalBalanceMoney => _totalBalanceMoney;

  double _totalDiscount = 0.0;
  double get totalDiscount => _totalDiscount;

  double _totalPixBalance = 0.0;
  double get totalPixBalance => _totalPixBalance;

  int _totalAmount = 0;
  int get totalAmount => _totalAmount;

  int _remainingAmount = 0;
  int get remainingAmount => _remainingAmount;

  double? _iceCreamShopProfit = 0.0;
  double? get iceCreamShopProfit => _iceCreamShopProfit;

  double? _sellersProfit = 0.0;
  double? get sellersProfit => _sellersProfit;

  double _netBalance = 0.0;
  double get netBalance => _netBalance;

  double _performancePercentage = 0.0;
  double get performancePercentage => _performancePercentage;

  void addNewSale(
      String paymentMethod, int amount, double discount, double totalBalance) {
    SaleModel newSale =
        SaleModel(paymentMethod, amount, discount, totalBalance);
    _salesHistory.add(newSale);
    notifyListeners();
  }

  void removeSale(int key) {
    _salesHistory.removeAt(key);
    notifyListeners();
  }

  void calculateTotalBalance() {
    if (_salesHistory.isNotEmpty) {
      _totalBalance = 0.0;
      _salesHistory.forEach((element) => _totalBalance += element.totalBalance);
      notifyListeners();
    }
  }

  void calculateTotalDiscount() {
    if (_salesHistory.isNotEmpty) {
      _totalDiscount = 0.0;
      _salesHistory
          .forEach((element) => _totalDiscount += element.discount as double);
    }
    notifyListeners();
  }

  void calculateTotalPixBalance() {
    List<SaleModel> listPixBalance = [];
    if (_salesHistory.isNotEmpty) {
      _totalPixBalance = 0.0;
      listPixBalance = _salesHistory
          .where((element) => element.paymentMethod == 'Pix')
          .toList();
      listPixBalance
          .forEach((element) => _totalPixBalance += element.totalBalance);
    }
    notifyListeners();
  }

  void calculateTotalBalanceMoney() {
    _totalPixBalance > 0
        ? _totalBalanceMoney = _totalBalance - _totalPixBalance
        : _totalBalanceMoney = _totalBalance;
    notifyListeners();
  }

  void calculateTotalAmount() {
    if (_salesHistory.isNotEmpty) {
      _totalAmount = 0;
      _salesHistory.forEach((element) {
        _totalAmount += element.amount;
      });
    } else {
      _totalAmount = 0;
    }
    notifyListeners();
  }

  void calculateRemaingAmount(int? totalAmount) {
    _remainingAmount = 0;
    _totalAmount > 0
        ? _remainingAmount = totalAmount! - _totalAmount
        : _remainingAmount = totalAmount!;
    notifyListeners();
  }

  void calculateIceCreamShopProfit(double? profitValue) {
    _totalAmount > 0
        ? _iceCreamShopProfit = profitValue! * _totalAmount
        : _iceCreamShopProfit = 0.0;
    notifyListeners();
  }

  void calculateSellerProfit(double? profitValue) {
    _totalAmount > 0
        ? _sellersProfit = profitValue! * _totalAmount
        : _sellersProfit = 0.0;
    notifyListeners();
  }

  void calculateNetBalance() {
    _totalDiscount > 0
        ? _netBalance = _totalBalance - _totalDiscount
        : _netBalance = _totalBalance;
    notifyListeners();
  }

  void calculatePerformancePercentage(int? totalAmount) {
    _totalAmount > 0
        ? _performancePercentage = (_totalAmount / totalAmount!) * 100
        : _performancePercentage = 0.0;
    notifyListeners();
  }
}
