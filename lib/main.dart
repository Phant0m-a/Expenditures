import 'dart:async';

import 'components/balance-container.dart';
import 'components/middle-container.dart';
import 'package:flutter/material.dart';
import 'utils/gsheet_api.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await gSheetApi().init();
  await gSheetApi().getCurrentTodo();
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
              const MiddleContainer(),
              // add button
              ElevatedButton(
                  onPressed: () {
                    const AddNew();
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

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'New expense or income',
        style: TextStyle(color: Colors.grey),
      ),
      backgroundColor: Colors.grey[200],
      content: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
                hintText: '\$ 00.0', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 3),
          const TextField(
            decoration: InputDecoration(
                hintText: 'income or expense', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'cancel',
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Enter',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
