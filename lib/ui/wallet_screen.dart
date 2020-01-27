import 'package:flutter/material.dart';
import 'package:wallet/model/operation.dart';
import 'package:wallet/ui/new_operation.dart';
import 'package:wallet/util/database_client.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  var db = DatabaseHelper();
  final List<Operation> _operationsList = <Operation>[];

  @override
  void initState() {
    super.initState();

    readOperationsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _operationsList.length,
              itemBuilder: (_, int index) {
                return Card(
                    child: ListTile(
                      title: _operationsList[index],
                    ));
              },
            ),
          ),
          Divider(
            height: 1.0,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add operation",
        backgroundColor: Colors.red,
        child: ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewOperation()),
          ).then((onValue) {
            setState(() {
              readOperationsList();
            });
          });
        },
      ),
    );
  }

  readOperationsList() async {
    _operationsList.clear();
    List items = await db.getOperations();
    items.forEach((item) {
      setState(() {
        _operationsList.add(Operation.map(item));
      });
    });
  }
}
