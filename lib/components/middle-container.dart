// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home/utils/gsheet_api.dart';

class MiddleContainer extends StatelessWidget {
  const MiddleContainer({super.key});



  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: ListView.builder(
        itemCount: gSheetApi.currentTodo.length,
        itemBuilder: (context, index) => Container(
          color: Colors.grey[100],
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: TransectionTile(amount: gSheetApi.currentTodo[index][0] , incomeOrexpense: gSheetApi.currentTodo[index][2], transectionName: gSheetApi.currentTodo[index][1],index:index),
        ),
      ),
    ));
  }
}

class TransectionTile extends StatefulWidget {
  const TransectionTile({super.key, required this.transectionName, required this.amount, required this.incomeOrexpense, required this.index});

  final String transectionName;
  final int amount;
  final String incomeOrexpense;
  final int index;

  @override
  State<TransectionTile> createState() => _TransectionTileState();
}

class _TransectionTileState extends State<TransectionTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.arrow_upward),
      title: Text(
       widget.transectionName ,
        style: TextStyle(color: Colors.green),
      ),
      trailing: Text(
        '\$ ${widget.incomeOrexpense == 'income'? "+": "-"} ${widget.amount}',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
