import 'package:flutter/material.dart';

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

  void handleSubmit() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      Navigator.pop(context, true);
    }
  }
}
