import 'package:flutter/material.dart';

class Operation extends StatelessWidget {
  DateTime _dateAdded;
  DateTime _dateOperation;
  double _amount;
  String _description;
  String _postingKey;
  int _id;

  Operation(this._dateAdded, this._dateOperation, this._amount, this._description, this._postingKey);

  Operation.map(dynamic obj) {
    this._dateAdded = obj["dateAdded"];
    this._dateOperation = obj["dateOperation"];
    this._amount = obj["amount"];
    this._description = obj["description"];
    this._postingKey = obj["postingKey"];
    this._id = obj["id"];
  }

  DateTime get dateAdded => _dateAdded;
  DateTime get dateOperation => _dateOperation;
  double get amount => _amount;
  String get description => _description;
  String get postingKey => _postingKey;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["dateAdded"] = _dateAdded;
    map["dateOperation"] = _dateOperation;
    map["amount"] = _amount;
    map["description"] = _description;
    map["postingKey"] = _postingKey;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Operation.fromMap(Map<String, dynamic> map) {
    this._dateAdded = map["dateAdded"];
    this._dateOperation = map["dateOperation"];
    this._amount = map["amount"];
    this._description = map["description"];
    this._postingKey = map["postingKey"];
    this._id = map["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}