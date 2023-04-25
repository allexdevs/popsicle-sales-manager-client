// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  int? _totalAmount = 0;
  int? get totalAmount => _totalAmount;

  double? _salePrice = 0;
  double? get salePrice => _salePrice;

  double? _iceCreamShopProfit = 0;
  double? get iceCreamShopProfit => _iceCreamShopProfit;

  double? _sellersProfit = 0;
  double? get sellersProfit => _sellersProfit;

  void changeSalePrice(value) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    if (value.toString().isNotEmpty) {
      double convertedValue = double.parse(value);
      await prefs.then((value) => value.setDouble('salePrice', convertedValue));
    } else {
      await prefs.then((value) => value.setDouble('salePrice', 0.0));
    }
    notifyListeners();
  }

  void fetchSalePrice() async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    await prefs
        .then((value) => _salePrice = value.getDouble('salePrice') ?? 0.0);
    notifyListeners();
  }

  void changeTotalAmount(value) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    if (value.toString().isNotEmpty) {
      int convertedValue = int.parse(value);
      await prefs.then((value) => value.setInt('totalAmount', convertedValue));
    } else {
      await prefs.then((value) => value.setInt('totalAmount', 0));
    }
    notifyListeners();
  }

  void fetchTotalAmount() async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    await prefs
        .then((value) => _totalAmount = value.getInt('totalAmount') ?? 0);
    notifyListeners();
  }

  void changeIceCreamShopProfit(value) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    if (value.toString().isNotEmpty) {
      double convertedvalue = double.parse(value);
      await prefs.then(
          (value) => value.setDouble('iceCreamShopProfit', convertedvalue));
    } else {
      await prefs.then((value) => value.setDouble('iceCreamShopProfit', 0.0));
    }
    notifyListeners();
  }

  void fetchIceCreamShopProfit() async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    await prefs.then((value) =>
        _iceCreamShopProfit = value.getDouble('iceCreamShopProfit') ?? 0.0);
    notifyListeners();
  }

  void changeSellersProfit(value) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    if (value.toString().isNotEmpty) {
      double convertedValue = double.parse(value);
      await prefs
          .then((value) => value.setDouble('sellersProfit', convertedValue));
    } else {
      await prefs.then((value) => value.setDouble('sellersProfit', 0.0));
    }
    notifyListeners();
  }

  void fetchSellersProfit() async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    await prefs.then(
        (value) => _sellersProfit = value.getDouble('sellersProfit') ?? 0.0);
    notifyListeners();
  }
}
