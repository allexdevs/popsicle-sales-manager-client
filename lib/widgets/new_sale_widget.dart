// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:popsicle_sales_manager_client/providers/balance_provider.dart';
import 'package:popsicle_sales_manager_client/providers/dashboard_provider.dart';
import 'package:popsicle_sales_manager_client/providers/history_provider.dart';
import 'package:popsicle_sales_manager_client/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import '../providers/new_sale_provider.dart';

class NewSaleWidget extends StatelessWidget {
  const NewSaleWidget(
      {super.key, required this.paymentMethods, this.discountCtrl});

  final List<Map<String, dynamic>> paymentMethods;
  final TextEditingController? discountCtrl;

  @override
  Widget build(BuildContext context) {
    int popsiclesSold = context.watch<NewSaleProvider>().amount;
    double saleBalance = context.watch<NewSaleProvider>().totalBalance;
    int totalAmount = context.watch<SettingsProvider>().totalAmount;
    double iceCreamShopProfit =
        context.watch<SettingsProvider>().iceCreamShopProfit;
    double sellersProfit = context.watch<SettingsProvider>().sellersProfit;
    int sold = context.watch<DashboardProvider>().popsiclesSold;
    String paymentMethod = context.watch<NewSaleProvider>().paymentMethod;
    double discount = context.watch<NewSaleProvider>().discount;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.60,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: Text(
              'Nova Venda',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
            child: SelectFormField(
              type: SelectFormFieldType.dropdown,
              initialValue: 'Dinheiro',
              icon: const Icon(Icons.payment),
              labelText: 'Método de Pagamento',
              items: paymentMethods,
              onChanged: (value) =>
                  context.read<NewSaleProvider>().changePaymentMethod(value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: const Text(
              'Quantidade',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
            trailing: SizedBox(
              width: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.pink.shade400)),
                      onPressed: () {
                        context.read<NewSaleProvider>().decrement();
                        context.read<NewSaleProvider>().calculateTotalBalance();
                      },
                      icon: const Icon(Icons.remove)),
                  Text(
                    '${context.watch<NewSaleProvider>().amount}',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<NewSaleProvider>().increment();
                        context.read<NewSaleProvider>().calculateTotalBalance();
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.money_off_rounded),
            title: const Text(
              'Desconto',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
            trailing: SizedBox(
              width: 120,
              child: TextField(
                controller: discountCtrl,
                onChanged: (value) {
                  context.read<NewSaleProvider>().changeDiscount(value);
                  context.read<NewSaleProvider>().calculateTotalBalance();
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    hintText: 'R\$ 0,00',
                    prefixIcon: Icon(Icons.attach_money)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: ListTile(
                leading: const Text(
                  'Total',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                trailing: Text(
                  'R\$ ${context.watch<NewSaleProvider>().totalBalanceWithDiscount.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                )),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.pink.shade400)),
                  onPressed: () {
                    if (popsiclesSold > 0) {
                      context
                          .read<DashboardProvider>()
                          .calculatePopsiclesSold(popsiclesSold);
                      context
                          .read<DashboardProvider>()
                          .calculateRemainingPopsicles(totalAmount);
                      context
                          .read<DashboardProvider>()
                          .calculateIceCreamShopProfit(iceCreamShopProfit);
                      context
                          .read<DashboardProvider>()
                          .calculateSellersProfit(sellersProfit);
                      context
                          .read<DashboardProvider>()
                          .calculatePerformancePercentage(
                              (sold + popsiclesSold), totalAmount);
                      context
                          .read<BalanceProvider>()
                          .calculateBalancePix(paymentMethod, saleBalance);
                      context
                          .read<BalanceProvider>()
                          .calculateBalanceMoney(paymentMethod, saleBalance);
                      context
                          .read<BalanceProvider>()
                          .calculateDiscountBalance(discount);
                      context.read<BalanceProvider>().calculateTotalBalance();
                      context.read<BalanceProvider>().calculateNetBalance();
                      context.read<NewSaleProvider>().clearAmount();
                      context.read<NewSaleProvider>().clearDiscount();
                      context.read<NewSaleProvider>().clearTotalBalance();
                      context.read<NewSaleProvider>().clearPaymentMethod();
                      discountCtrl!.clear();
                      context.read<HistoryProvider>().addNewSale(
                          paymentMethod, popsiclesSold, discount, saleBalance);
                      context.read<HistoryProvider>().calculateTotalBalance();
                      context.read<HistoryProvider>().calculateTotalDiscount();
                      context.read<HistoryProvider>().calculateTotalAmount();
                      context
                          .read<HistoryProvider>()
                          .calculateRemaingAmount(totalAmount);
                      context
                          .read<HistoryProvider>()
                          .calculateTotalPixBalance();
                      context
                          .read<HistoryProvider>()
                          .calculateTotalBalanceMoney();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Salvar', style: TextStyle(fontSize: 16))),
            ),
          )
        ],
      ),
    );
  }
}
