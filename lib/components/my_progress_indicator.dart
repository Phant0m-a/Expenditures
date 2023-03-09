import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 5,
        child: LinearProgressIndicator(
          color: Colors.grey.shade200,
          backgroundColor: Colors.grey.shade100,
          minHeight: 2,
        ));
  }
}
