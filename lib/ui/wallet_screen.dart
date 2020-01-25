import 'package:flutter/material.dart';
import 'package:wallet/ui/new_operation.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add operation",
        backgroundColor: Colors.red,
        child: ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: () {
          //_showDialog(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewOperation()),
          );
        },
      ),
    );
  }
}
