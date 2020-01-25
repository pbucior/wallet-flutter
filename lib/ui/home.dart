import 'package:flutter/material.dart';

import 'wallet_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
        backgroundColor: Colors.blue,
      ),
      body: WalletScreen(),
    );
  }
}