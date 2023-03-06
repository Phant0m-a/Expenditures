// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BalanceContainer extends StatelessWidget {
  const BalanceContainer(
      {super.key,
      required this.balance,
      required this.income,
      required this.expense});

  final balance;
  final income;
  final expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: Colors.white,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(-4, -4)),
        BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(4, 4)),
      ], color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'B a l a n c e',
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
          ),
          Text(
            '\$ $balance',
            style: TextStyle(color: Colors.grey[800], fontSize: 40),
          ),

          //income or expense
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //income
              Row(
                children: [
                  //circle
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),

                  //text
                  Column(
                    children: [
                      Text(
                        'Income',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '\$ $income',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ],
                  )
                ],
              ),
              //expense
              Row(
                children: [
                  //circle
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  //text

                  Column(
                    children: [
                      Text(
                        'Income',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '\$ $expense',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
