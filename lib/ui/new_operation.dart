import 'package:flutter/material.dart';
import 'package:wallet/model/operation.dart';
import 'package:wallet/util/date_format.dart';
import 'package:wallet/util/database_client.dart';

class NewOperation extends StatefulWidget {
  @override
  _NewOperationState createState() => _NewOperationState();
}

class _NewOperationState extends State<NewOperation> {
  final _formKey = GlobalKey<FormState>();
  String description;
  double amount;
  int radioValue = 0;
  String postingKey = "Expense";
  DateTime dateOperation = DateTime.now();
  var db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New operation'),
      ),
      body: Column(
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (val) => description = val,
                      decoration: new InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(),
                        icon: new Icon(Icons.description),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a description';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (val) => amount = double.parse(val),
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: "Amount",
                        border: OutlineInputBorder(),
                        icon: new Icon(Icons.attach_money),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter the amount';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )),
          OutlineButton(
            child: Text(formatDate(dateOperation)),
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2099))
                  .then((date) {
                if (date != null) {
                  setState(() {
                    dateOperation = date;
                  });
                }
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio<int>(
                value: 0,
                groupValue: radioValue,
                onChanged: handleRadioValueChanged,
              ),
              Text('Expense'),
              Radio<int>(
                value: 1,
                groupValue: radioValue,
                onChanged: handleRadioValueChanged,
              ),
              Text('Profit'),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handleSubmit();
        },
        tooltip: 'Add operation',
        child: Icon(Icons.save),
      ),
    );
  }

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      switch (radioValue) {
        case 0:
          postingKey = 'Expense';
          break;
        case 1:
          postingKey = 'Profit';
          break;
        default:
          postingKey = '';
      }
    });
  }

  void handleSubmit() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      Operation operation = Operation(nowTimeStamp(), formatDate(dateOperation),
          amount, description, postingKey);
      await db.saveItem(operation);
      Navigator.pop(context, true);
    }
  }
}
