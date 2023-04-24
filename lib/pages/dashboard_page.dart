// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:popsicle_sales_manager_client/providers/balance_provider.dart';
import 'package:popsicle_sales_manager_client/providers/dashboard_provider.dart';
import 'package:popsicle_sales_manager_client/providers/history_provider.dart';
import 'package:popsicle_sales_manager_client/providers/settings_provider.dart';
import 'package:popsicle_sales_manager_client/widgets/new_sale_widget.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'value': 'Dinheiro',
      'label': 'Dinheiro',
      'icon': const Icon(Icons.attach_money_rounded)
    },
    {'value': 'Pix', 'label': 'PIX', 'icon': const Icon(Icons.pix_rounded)},
  ];

  TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double moneyBalance = context.watch<BalanceProvider>().balanceMoney;
    double pixBalance = context.watch<BalanceProvider>().pixBalance;
    double totalBalance = context.watch<BalanceProvider>().totalBalance;
    double discountBalance = context.watch<BalanceProvider>().discountBalance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/history'),
              icon: const Icon(Icons.sort_rounded)),
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/qrcode'),
              icon: const Icon(Icons.qr_code_scanner_rounded)),
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 190,
                  height: 200,
                  child: Visibility(
                    replacement: const SizedBox.shrink(),
                    visible: moneyBalance > 0 ||
                        pixBalance > 0 ||
                        totalBalance > 0 ||
                        discountBalance > 0,
                    child: DChartPie(
                      data: [
                        {
                          'domain': 'Dinheiro',
                          'measure':
                              context.watch<HistoryProvider>().totalBalanceMoney
                        },
                        {
                          'domain': 'Pix',
                          'measure':
                              context.watch<HistoryProvider>().totalPixBalance
                        },
                        {
                          'domain': 'Total',
                          'measure':
                              context.watch<HistoryProvider>().totalBalance
                        },
                        {
                          'domain': 'Desconto',
                          'measure':
                              context.watch<HistoryProvider>().totalDiscount
                        },
                      ],
                      pieLabel: (pieData, index) => index == 0
                          ? "R\$\n${pieData['measure']}"
                          : index == 1
                              ? "Pix\n${pieData['measure']}"
                              : index == 2
                                  ? "Total\n${pieData['measure']}"
                                  : "-R\$\n${pieData['measure']}",
                      fillColor: (pieData, index) => index == 0
                          ? Colors.green.shade500
                          : index == 1
                              ? Colors.pink.shade400
                              : index == 2
                                  ? Colors.purple.shade400
                                  : Colors.red,
                      donutWidth: 45,
                      labelColor: Colors.white,
                      showLabelLine: false,
                      labelPosition: PieLabelPosition.inside,
                    ),
                  ),
                ),
                SizedBox(
                  width: 190,
                  height: 200,
                  child: DChartBar(
                      showBarValue: true,
                      barValueColor: Colors.black87,
                      barValuePosition: BarValuePosition.outside,
                      barValue: (barData, index) => index == 0
                          ? "${barData['measure']}"
                          : "${barData['measure']}",
                      barColor: ((barData, index, id) => index == 0
                          ? Colors.green.shade400
                          : Colors.pink.shade400),
                      data: [
                        {
                          'id': 'bar',
                          'data': [
                            {
                              'domain': 'Qtd. Total',
                              'measure':
                                  context.watch<SettingsProvider>().totalAmount
                            },
                            {
                              'domain': 'R\$ Total',
                              'measure': context
                                      .watch<SettingsProvider>()
                                      .salePrice *
                                  context.watch<SettingsProvider>().totalAmount
                            },
                          ]
                        }
                      ]),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 20.0),
              child: Text('Quantidade',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.green.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Card(
                elevation: 6,
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text('Picolés Restantes',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(
                          '${context.watch<HistoryProvider>().remainingAmount}',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black45,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text('Picolés Vendidos',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('${context.watch<HistoryProvider>().totalAmount}',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black45,
                              fontSize: 18,
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 10.0),
              child: Text('Lucro',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.green.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Card(
                elevation: 6,
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Lucro Sorveteria',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                          'R\$ ${context.watch<DashboardProvider>().iceCreamShopProfit.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black45,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Lucro Vendedor',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'R\$ ${context.watch<DashboardProvider>().sellersProfit.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black45,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 10.0),
              child: Text('Saldo',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.green.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Card(
                elevation: 6,
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Dinheiro',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                          'R\$ ${context.watch<HistoryProvider>().totalBalanceMoney.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black45,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Pix',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'R\$ ${context.watch<HistoryProvider>().totalPixBalance.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black45,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: const Text('Percentual de Desempenho',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black54,
                          fontWeight: FontWeight.w600)),
                  trailing: Text(
                      '${context.watch<DashboardProvider>().performancePercentage.toStringAsFixed(2)} %',
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black54,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  width: 350,
                  height: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DChartSingleBar(
                      radius: const BorderRadius.all(Radius.circular(30)),
                      forgroundColor: Colors.indigo,
                      value: context
                          .watch<DashboardProvider>()
                          .performancePercentage,
                      max: 100),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: ListTile(
                    leading: const Text('Saldo Líquido',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                            '- R\$ ${context.watch<BalanceProvider>().discountBalance.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.red.shade500)),
                        Text(
                            'R\$ ${context.watch<BalanceProvider>().netBalance.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade500)),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
                builder: (BuildContext context) {
                  return NewSaleWidget(
                    paymentMethods: _paymentMethods,
                    discountCtrl: discountController,
                  );
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
