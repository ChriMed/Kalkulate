import 'package:flutter/material.dart';
import 'login_screen.dart';
void main() => runApp(const BankingApp());


class BankingApp extends StatelessWidget {
  const BankingApp({super.key});




  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),      //   StopWatch(),

    );
  }
}
