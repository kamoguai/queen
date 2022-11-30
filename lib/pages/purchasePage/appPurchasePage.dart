import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class AppPurchasePage extends StatefulWidget {
  const AppPurchasePage({super.key});

  @override
  State<AppPurchasePage> createState() => _AppPurchasePageState();
}

class _AppPurchasePageState extends State<AppPurchasePage> {
  late double _deviceWidth;
  late double _deviceHeight;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(appBar: AppBar(), body: _body());
  }

  Widget _body() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () async {
              await Purchases.purchaseProduct('rc_10_coin');
            },
            child: const Text('Buy Coins')),
        SizedBox(
          height: _deviceHeight * 0.05,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () async {
              await Purchases.purchaseProduct('function_100_1m');
            },
            child: const Text('Buy Subscription')),
      ]),
    );
  }
}
