import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home/components/balance-container.dart';
import 'package:home/utils/gsheet_api.dart';

import '../../components/middle-container.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
//controllers
  final TextEditingController _transectionNameController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void resetter() {
    setState(() {
      // GSheetApi.numberofTransection = 0;
      // GSheetApi.currentTransections.clear();
      // GSheetApi.loading = true;
      // timerStarter = false;

      // GSheetApi.balance = 0;
      // GSheetApi.income = 0;
      // GSheetApi.expense = 0;

      //startLoadingTransections();
    });
  }

  //load method
  bool timerStarter = false;
  void startLoadingTransections() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GSheetApi.loading == false) {
        setState(() {});

        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GSheetApi.loading == true && timerStarter == false) {
      startLoadingTransections();
    }
    bool myincome = false;
//show dialog
    void showNewDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (BuildContext context, setState) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text(
                    'new expense or income',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.grey[200],
                  content: SizedBox(
                    child: Column(
                      children: [
                        //switch
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Expense'),
                            Switch(
                                value: myincome,
                                onChanged: (value) {
                                  setState(() {
                                    myincome = value;
                                  });
                                }),
                            const Text('Income'),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // price
                        TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                              hintText: '\$ 00.0',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 3),
                        //item name
                        TextField(
                          controller: _transectionNameController,
                          decoration: const InputDecoration(
                              hintText: 'item name',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'cancel',
                                  style: TextStyle(color: Colors.white),
                                )),
                            const SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: () async {
                                  // if (_formKey.currentState!.validate()) {
                                  //   //add new transection
                                  //   Navigator.of(context).pop();
                                  // }

                                  if (_transectionNameController.text.trim() !=
                                          '' &&
                                      _amountController.text.trim() != '') {
                                    await GSheetApi.postNew(
                                        _transectionNameController.text.trim(),
                                        _amountController.text.trim(),
                                        myincome);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return const AlertDialog(
                                            title: Text('Error'),
                                            content: Text(
                                                'Please fill out both text fields!'),
                                          );
                                        }));
                                  }

                                  // resetter();
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Enter',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
          });
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  // balance container
                  BalanceContainer(
                    balance: GSheetApi.balance,
                    expense: GSheetApi.expense,
                    income: GSheetApi.income,
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                      child: GSheetApi.loading == true
                          ? const Text('loading')
                          : ListView.builder(
                              itemCount: GSheetApi.allTransections.length,
                              itemBuilder: (context, index) => Container(
                                color: Colors.grey[100],
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: TransectionTile(
                                  transectionName:
                                      GSheetApi.allTransections[index][0],
                                  amount: GSheetApi.allTransections[index][1],
                                  incomeOrexpense:
                                      GSheetApi.allTransections[index][2],
                                ),
                              ),
                            )),
                  ElevatedButton(
                      onPressed: () {
                        showNewDialog(context);
                      },
                      child: const Text(
                        '+',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
