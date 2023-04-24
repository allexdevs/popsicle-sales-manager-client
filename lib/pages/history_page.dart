import 'package:flutter/material.dart';
import 'package:popsicle_sales_manager_client/models/sale_model.dart';
import 'package:popsicle_sales_manager_client/providers/history_provider.dart';
import 'package:popsicle_sales_manager_client/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<SaleModel> salesHistory =
        context.watch<HistoryProvider>().salesHistory;
    int amount = context.watch<SettingsProvider>().totalAmount;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Histórico de Vendas'),
        ),
        body: Visibility(
          visible: salesHistory.isEmpty,
          replacement: ListView.builder(
              itemCount: salesHistory.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    context.read<HistoryProvider>().removeSale(index);
                    context.read<HistoryProvider>().calculateTotalBalance();
                    context
                        .read<HistoryProvider>()
                        .calculateTotalBalanceMoney();
                    context.read<HistoryProvider>().calculateTotalDiscount();
                    context.read<HistoryProvider>().calculateTotalPixBalance();
                    context.read<HistoryProvider>().calculateTotalAmount();
                    context
                        .read<HistoryProvider>()
                        .calculateRemaingAmount(amount);
                  },
                  minLeadingWidth: 20,
                  leading: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.local_offer_rounded,
                          color: Colors.pink.shade300,
                        ),
                      ],
                    ),
                  ),
                  title: const Text('Método de Pagamento',
                      style: TextStyle(
                          fontFamily: 'montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54)),
                  subtitle: Text(
                      '${salesHistory[index].paymentMethod} - Qtd.: ${salesHistory[index].amount}',
                      style: TextStyle(
                          fontFamily: 'montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink.shade400)),
                  trailing: SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const Text('Total',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                  // ignore: unnecessary_string_interpolations
                                  '- ${salesHistory[index].discount!.toStringAsFixed(2).replaceAll(".", ",")} / ',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Colors.red.shade300,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  // ignore: unnecessary_string_interpolations
                                  '${salesHistory[index].totalBalance.toStringAsFixed(2).replaceAll(".", ",")}',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Colors.green.shade400,
                                      fontWeight: FontWeight.w700)),
                            ],
                          )
                        ],
                      )),
                );
              }),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.error_outline_rounded,
                    color: Colors.black12, size: 72),
                SizedBox(
                  height: 20,
                ),
                Text('Nenhuma venda realizada',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600))
              ],
            ),
          ),
        ));
  }
}
