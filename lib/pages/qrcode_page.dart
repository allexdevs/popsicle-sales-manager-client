import 'package:flutter/material.dart';

class QrcodePage extends StatelessWidget {
  const QrcodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pagar com QR Code'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Center(
                    child: Image.asset(
                  width: 280,
                  fit: BoxFit.fill,
                  'assets/images/qrcode.png',
                )),
              ),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle_rounded,
                        color: Colors.pink.shade400),
                  ],
                ),
                title: const Text(
                  'Nome',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                subtitle: const Text(
                  'Alex Santos Nunes',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.credit_card_rounded,
                        color: Colors.pink.shade400),
                  ],
                ),
                title: const Text(
                  'CPF',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                subtitle: const Text(
                  '***.773.094-**',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.account_balance_outlined,
                        color: Colors.pink.shade400),
                  ],
                ),
                title: const Text(
                  'Instituição Financeira',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                subtitle: const Text(
                  'Nu Pagamentos SA.',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ));
  }
}
