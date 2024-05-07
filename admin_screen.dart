//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:kalkulate_app/bank_account.dart';
import 'package:kalkulate_app/login_screen.dart';

import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.orange,
        title: Text('Admin Page'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (_) => LoginScreen()
                ),
              );
            },
            child: Text('Back to Login Screen'),
            //SizedBox(height: 20),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: bank.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(bank[index].username + ' '),
            subtitle: Text('Savings: \$${bank[index].Savings.Balance} \t Checkings: \$${bank[index].Checkings.Balance} '
                '\n Password: ${bank[index].password}'),
          );
        },

      ),

      // Add other widgets or functionality here
    );
  }
}
