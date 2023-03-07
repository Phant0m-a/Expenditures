import 'dart:async';

import 'components/balance-container.dart';
import 'components/middle-container.dart';
import 'package:flutter/material.dart';
import 'utils/gsheet_api.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await gSheetApi().init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Expense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: ExpenseTracker(),
    );
  }
}

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

  //load method
  bool timerStarter = false;
  void startLoadingTransections() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (gSheetApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (gSheetApi.loading == true && timerStarter == false) {
      startLoadingTransections();
    }
    bool myincome = false;
//show dialog
    void showNewDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (BuildContext context, setState) {
              return AlertDialog(
                title: const Text(
                  'new expense or income',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.grey[200],
                content: SizedBox(
                  height: 250,
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
                            hintText: '\$ 00.0', border: OutlineInputBorder()),
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
                                await gSheetApi.postNew(
                                    _transectionNameController.text.trim(),
                                    _amountController.text.trim(),
                                    myincome);
                                setState(() {
                                  gSheetApi.loading = true;
                                  timerStarter = false;
                                });
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
              );
            });
          });
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              // balance container
              const BalanceContainer(
                balance: 20000,
                expense: 1500,
                income: 500,
              ),
              const SizedBox(height: 10),
              // middle - container
              gSheetApi.loading == true
                  ? Expanded(
                      child: Container(
                          width: double.infinity,
                          height: 5,
                          child: LinearProgressIndicator(
                            color: Colors.grey.shade200,
                            backgroundColor: Colors.grey.shade100,
                            minHeight: 2,
                          )),
                    )
                  : Expanded(
                      child: Container(
                      child: ListView.builder(
                        itemCount: gSheetApi.currentTransections.length,
                        itemBuilder: (context, index) => Container(
                          color: Colors.grey[100],
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          child: TransectionTile(
                            transectionName:
                                gSheetApi.currentTransections[index][0],
                            amount: gSheetApi.currentTransections[index][1],
                            incomeOrexpense:
                                gSheetApi.currentTransections[index][2],
                          ),
                        ),
                      ),
                    )),
              // add button
              ElevatedButton(
                  onPressed: () {
                    showNewDialog();
                  },
                  child: const Text(
                    '+',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: fix reload after new transection is added!