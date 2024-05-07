import 'package:flutter/material.dart';
import 'package:kalkulate_app/login_screen.dart';
import 'bank_account.dart';


class DepositPage extends StatefulWidget {
  final String name;
  final String password;

  DepositPage({super.key,required this.name, required this.password});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulate App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BankingPage(),
    );
  }
}


class BankingPage extends StatefulWidget {
//  const BankingPage({super.key});

  @override
  State<BankingPage> createState() => _BankingPageState();
}


class _BankingPageState extends State<BankingPage> {
    TextEditingController _controller = TextEditingController();
    List<String> transactions = [];
    //List<String> transactions = [];

    

    void _depositAmount(double amount) {
      bank[userIndex].Checkings.deposit(amount);
      setState(() {
        transactions.add('Deposit: \$ ${amount.toStringAsFixed(2)}');
      });
    }
    void _transactAmount(double amount) {
      bank[userIndex].Checkings.transact(amount);
      setState(() {
        transactions.add('Transaction: -\$ ${amount.toStringAsFixed(2)}');
      });
    }

    void _transfer(bool fromSavingsToCheckings) {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Amount to Transfer'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(child: Text('Transfer'),
            onPressed:  () {
            double amount = double.parse(_controller.text);
            bank[userIndex].transfer(fromSavingsToCheckings, amount);
              setState(() {
                if(fromSavingsToCheckings)
                  transactions.add('Transfer of: \$ ${amount.toStringAsFixed(2)} to Checkings');
                else
                  transactions.add('Transfer of: \$ ${amount.toStringAsFixed(2)} to Savings');

              });


            _controller.clear();
            Navigator.of(context).pop();
          },
            ),
          ],
        );
      },
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.orange,
        title:  Text(bank[userIndex].username +"'s "+ 'Bank Account'),
      ),
      body: Padding(

        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(onPressed: () {
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Enter Amount to Deposit'),
                  content: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                  ),
                  actions: <Widget>[
                    TextButton(child: Text('Deposit', style: TextStyle( color: Colors.black)), onPressed: () {
                      double amount = double.parse(_controller.text);
                      _depositAmount(amount);
                      _controller.clear();
                      Navigator.of(context).pop();
                    },)
                  ],
                );
              },
              );
            },


              child:
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Deposit',
                style: TextStyle(fontSize: 18),
              ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                ),
              ),
            ),
            ElevatedButton(onPressed: () {
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Enter Amount to Transact'),
                  content: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                  ),
                  actions: <Widget>[
                    TextButton(child: Text('Transaction ', style: TextStyle( color: Colors.black)), onPressed: () {
                      double amount = double.parse(_controller.text);
                      _transactAmount(amount);
                      _controller.clear();
                      Navigator.of(context).pop();
                    },)
                  ],
                );
              },
              );
            },
              child:
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Transactions',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                ),
              ),
            ),
            //SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              _transfer(true);
            },
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Transfer: Savings to Checkings',
                style: TextStyle(fontSize: 18),
              ),
            ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                ),
              ),
            ),
            //SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              _transfer(false);
            },
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Transfer: Checking to Savings',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.orange),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                ),
              ),
            ),
            //SizedBox(height: 20),
            Text('Current Checkings Balance: \$${bank[userIndex].Checkings.Balance.toStringAsFixed(2)}\n'
                +'Current Savings Balance: \$${bank[userIndex].Savings.Balance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight:  FontWeight.bold),
            ),
            Text(
              'Banking History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int userIndex) {
                return ListTile(
                  title: Text(transactions[userIndex]),
                );
              },
            ),
            ),
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
      ),
    );
  }
  @override
    void dispose() {
      // TODO: implement dispose
      _controller.dispose();
      super.dispose();
    }
}
























