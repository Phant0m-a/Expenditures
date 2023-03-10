import 'package:home/utils/pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'utils/gsheet_api.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await GSheetApi().init();
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
      theme: ThemeData(primarySwatch: Colors.green,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  SplashScreen(),
    );
  }
}




