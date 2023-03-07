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
        itemCount: gSheetApi.currentTransections.length,
        itemBuilder: (context, index) => Container(
          color: Colors.grey[100],
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: TransectionTile(
            amount: gSheetApi.currentTransections[index][0],
            transectionName: gSheetApi.currentTransections[index][1],
            incomeOrexpense: gSheetApi.currentTransections[index][2],
          ),
        ),
      ),
    ));
  }
}

class TransectionTile extends StatelessWidget {
  const TransectionTile({
    super.key,
    required this.transectionName,
    required this.amount,
    required this.incomeOrexpense,
  });

  final String transectionName;
  final String amount;
  final String incomeOrexpense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(50),
        ),
        child: incomeOrexpense.toString() == 'expense'
            ? Icon(Icons.arrow_downward, color: Colors.red)
            : Icon(
                Icons.arrow_upward,
                color: Colors.green,
              ),
      ),
      title: Text(
        transectionName,
        style: TextStyle(color: Colors.green),
      ),
      trailing: Text(
        '\$ ${incomeOrexpense == 'income' ? "+" : "-"}$amount',
        style: TextStyle(
            color: incomeOrexpense == 'income' ? Colors.green : Colors.red),
      ),
    );
  }
}
