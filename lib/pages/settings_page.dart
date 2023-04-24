// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:popsicle_sales_manager_client/providers/dashboard_provider.dart';
import 'package:popsicle_sales_manager_client/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final TextEditingController? totalAmountController = TextEditingController();
  final TextEditingController? salePriceController = TextEditingController();
  final TextEditingController? iceCreamShopProfitController =
      TextEditingController();
  final TextEditingController? sellersProfitController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 8.0, bottom: 8.0),
              child: Text('Preço de Venda',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: TextField(
                    controller: salePriceController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        context.read<SettingsProvider>().changeSalePrice(value),
                    decoration: const InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(60))),
                        hintText: 'Ex.: R\$ 2,00'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                      'R\$ ${context.watch<SettingsProvider>().salePrice.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 8, bottom: 8.0),
              child: Text('Quantidade Total',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: TextField(
                    controller: totalAmountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      context.read<SettingsProvider>().changeTotalAmount(value);
                      context
                          .read<DashboardProvider>()
                          .calculateRemainingPopsicles(int.parse(value));
                    },
                    decoration: const InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(60))),
                        hintText: 'Ex.: 100'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                      'Qtd. ${context.watch<SettingsProvider>().totalAmount}',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 8.0, bottom: 8.0),
              child: Text('Lucro da Sroveteria',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: TextField(
                    controller: iceCreamShopProfitController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      context
                          .read<SettingsProvider>()
                          .changeIceCreamShopProfit(value);
                    },
                    decoration: const InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(60))),
                        hintText: 'Ex.: R\$ 1.20'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                      'R\$ ${context.watch<SettingsProvider>().iceCreamShopProfit.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 8.0, bottom: 8),
              child: Text('Lucro do Vendedor',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: TextField(
                    controller: sellersProfitController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      context
                          .read<SettingsProvider>()
                          .changeSellersProfit(value);
                    },
                    decoration: const InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(60))),
                        hintText: 'Ex.: R\$ 0.80'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                      'R\$ ${context.watch<SettingsProvider>().sellersProfit.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
