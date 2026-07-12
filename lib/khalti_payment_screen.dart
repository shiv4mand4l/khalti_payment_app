import 'package:flutter/material.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

class KhaltiPaymentScreen extends StatefulWidget {
  const KhaltiPaymentScreen({super.key});

  @override
  State<KhaltiPaymentScreen> createState() => _KhaltiPaymentScreenState();
}

class _KhaltiPaymentScreenState extends State<KhaltiPaymentScreen> {
  late final Future<Khalti?> khalti;
  bool isLoading = false;

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
        child: Column(
          mainAxisAlignment: .center,
          spacing: 10,
          children: [
            Text('Khalti Payment'),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green[100]),
                padding: .all(
                  EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Pay 💳',
                style: TextStyle(fontSize: 24, fontWeight: .bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
