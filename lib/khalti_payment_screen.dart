import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
import 'package:khalti_payment_app/utils/khalti_services.dart';

class KhaltiPaymentScreen extends StatefulWidget {
  const KhaltiPaymentScreen({super.key});

  @override
  State<KhaltiPaymentScreen> createState() => _KhaltiPaymentScreenState();
}

class _KhaltiPaymentScreenState extends State<KhaltiPaymentScreen> {
  // late final Future<Khalti?> khalti;
  Khalti? _khalti;
  bool isLoading = false;
  PaymentResult? paymentResult;

  Future<void> payWithKhaltiCheckOut(int amount) async {
    try {
      setState(() {
        isLoading = true;
      });

      // ----------------------- Step First----------------------------------------
      final pidxNumber = await KhaltiServices.generatePidx(amount);
      print('Pidx Number is: ${pidxNumber}');

      // --------------------------Step Second-------------------------------
      final config = KhaltiPayConfig(
        paymentUrl:
            'https://test-pay.khalti.com/?pidx=$pidxNumber&return_url=https%3A%2F%2Fdocs.khalti.com%2Fkhalti-epayment&mode=wallet',
        publicKey: '3a895daf55d54e6a8937dbec60fc0a69',
        pidx: pidxNumber!,
        environment: Environment.test,
      );
      // --------------------------Step Third-------------------------------
      _khalti = await Khalti.init(
        enableDebugging: true,
        payConfig: config,
        onPaymentResult: (paymentResult, khalti) {
          log(paymentResult.toString());
          setState(() {
            this.paymentResult = paymentResult;
          });
          khalti.close(context);
        },
        onMessage:
            (
              khalti, {
              description,
              statusCode,
              event,
              needsPaymentConfirmation,
            }) async {
              log(
                'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
              );
              khalti.close(context);
            },
        onReturn: () => log('Successfully redirected to return_url.'),
      );

      // --------------------------Step Third-------------------------------
    } catch (e) {
      log('Inilization Error: ${e.toString()}');
    } finally {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: Text('Khalti Payment App'),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),

      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green[100]),
                  padding: .all(
                    EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  ),
                ),
                onPressed: () {
                  payWithKhaltiCheckOut(100);
                },
                child: Text(
                  'Pay 💳',
                  style: TextStyle(fontSize: 24, fontWeight: .bold),
                ),
              ),
      ),
    );
  }
}
