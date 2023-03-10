import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home/utils/pages/main_copy.dart';

class SplashScreen extends StatefulWidget {  
  @override  
  SplashScreenState createState() => SplashScreenState();  
}  
class SplashScreenState extends State<SplashScreen> {  
  @override  
  void initState() {  
    super.initState();  
    Timer(Duration(seconds: 5),  
            ()=>Navigator.pushReplacement(context,  
            MaterialPageRoute(builder:  
                (context) => ExpenseTracker()  
            )  
         )  
    );  
  }  
  @override  
  Widget build(BuildContext context) {  
    return Container(  
        color: Colors.yellow,  
        child:FlutterLogo(size:MediaQuery.of(context).size.height)  
    );  
  }  
}  