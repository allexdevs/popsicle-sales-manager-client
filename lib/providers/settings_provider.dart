import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  int _totalAmount = 0;
  int get totalAmount => _totalAmount;

  double _salePrice = 0;
  double get salePrice => _salePrice;

  double _iceCreamShopProfit = 0;
  double get iceCreamShopProfit => _iceCreamShopProfit;

  double _sellersProfit = 0;
  double get sellersProfit => _sellersProfit;

  void changeSalePrice(value) {
    if (value.toString().isNotEmpty) {
      double convertedValue = double.parse(value);
      _salePrice = convertedValue;
    } else {
      _salePrice = 0;
    }
    notifyListeners();
  }

  void changeTotalAmount(value) {
    if (value.toString().isNotEmpty) {
      int convertedValue = int.parse(value);
      _totalAmount = convertedValue;
    } else {
      _totalAmount = 0;
    }
    notifyListeners();
  }

  void changeIceCreamShopProfit(value) {
    if (value.toString().isNotEmpty) {
      double convertedvalue = double.parse(value);
      _iceCreamShopProfit = convertedvalue;
    } else {
      _iceCreamShopProfit = 0;
    }
    notifyListeners();
  }

  void changeSellersProfit(value) {
    if (value.toString().isNotEmpty) {
      double convertedValue = double.parse(value);
      _sellersProfit = convertedValue;
    } else {
      _sellersProfit = 0;
    }
    notifyListeners();
  }
}
