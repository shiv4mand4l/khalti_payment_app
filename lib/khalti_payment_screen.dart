import 'package:flutter/material.dart';

class KhaltiPaymentScreen extends StatefulWidget {
  const KhaltiPaymentScreen({super.key});

  @override
  State<KhaltiPaymentScreen> createState() => _KhaltiPaymentScreenState();
}

class _KhaltiPaymentScreenState extends State<KhaltiPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khalti Payment App'),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),

      body: Column(children: [
      
    ],),
    );
  }
}
