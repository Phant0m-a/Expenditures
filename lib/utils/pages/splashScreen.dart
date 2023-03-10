import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home/utils/pages/expense_tracker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  @override  
  SplashScreenState createState() => SplashScreenState();  
}  
class SplashScreenState extends State<SplashScreen> {  
  @override  
  void initState() {  
    super.initState();  
    Timer(const Duration(seconds: 4),  
            ()=>Navigator.pushReplacement(context,  
            MaterialPageRoute(builder:  
                (context) => const ExpenseTracker()  
            )  
         )  
    );  
  }  
  @override  
  Widget build(BuildContext context) {  
    return Container(  
        color: Colors.grey[200],  
        child:FlutterLogo(size:MediaQuery.of(context).size.height)  
    );  
  }  
}  