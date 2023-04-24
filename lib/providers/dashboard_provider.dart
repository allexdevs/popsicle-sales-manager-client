import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  int _remainingPopsicles = 0;
  int get remainingPopsicles => _remainingPopsicles;

  int _popsiclesSold = 0;
  int get popsiclesSold => _popsiclesSold;

  double _iceCreamShopProfit = 0;
  double get iceCreamShopProfit => _iceCreamShopProfit;

  double _sellersProfit = 0;
  double get sellersProfit => _sellersProfit;

  double _performancePercentage = 0;
  double get performancePercentage => _performancePercentage;

  void calculateRemainingPopsicles(value) {
    int convertedValue = value;
    _popsiclesSold > 0 && convertedValue > 0
        ? _remainingPopsicles = (convertedValue - _popsiclesSold)
        : _remainingPopsicles = convertedValue;
    notifyListeners();
  }

  void calculatePopsiclesSold(value) {
    int convertedValue = value;
    _popsiclesSold += convertedValue;
    notifyListeners();
  }

  void calculateIceCreamShopProfit(value) {
    double convertedValue = value;
    _popsiclesSold > 0
        ? _iceCreamShopProfit = _popsiclesSold * convertedValue
        : _iceCreamShopProfit = 0;
    notifyListeners();
  }

  void calculateSellersProfit(value) {
    double convertedValue = value;
    _popsiclesSold > 0
        ? _sellersProfit = _popsiclesSold * convertedValue
        : _sellersProfit = 0;
    notifyListeners();
  }

  void calculatePerformancePercentage(int soldAmount, int totalAmount) {
    if (soldAmount.toString().isNotEmpty) {
      _performancePercentage = (soldAmount / totalAmount) * 100;
    } else {
      _performancePercentage = 0;
    }
  }
}
