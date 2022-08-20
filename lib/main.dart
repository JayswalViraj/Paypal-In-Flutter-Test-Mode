import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String tokenizationKey = 'Your Tokenization Keys'; /// For use in Braintree SDKs

  void showNonce(BraintreePaymentMethodNonce nonce) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Payment method nonce:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Nonce: ${nonce.nonce}'),
            SizedBox(height: 16),
            Text('Type label: ${nonce.typeLabel}'),
            SizedBox(height: 16),
            Text('Description: ${nonce.description}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Paypal In Flutter Test Mode")),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              var request = BraintreeDropInRequest(
                tokenizationKey: tokenizationKey,
                collectDeviceData: true,
                paypalRequest: BraintreePayPalRequest(
                  amount: '4.20',
                  displayName: 'Unkown Company',
                ),
              );
              final result = await BraintreeDropIn.start(request);
              if (result != null) {
                showNonce(result.paymentMethodNonce);
              }
            },
            child: Text("Pay 4.20 USD")),
      ),
    );
  }
}
