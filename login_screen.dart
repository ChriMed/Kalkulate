import 'package:flutter/material.dart';
import 'package:kalkulate_app/admin_screen.dart';
import 'package:kalkulate_app/deposit_page.dart';
import 'package:kalkulate_app/bank_account.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  String name = '';
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        title: const Text('Login'),
      ),
      body: Center(
        child: _buildLoginForm(),
      ),

    );
  }


  void _validate() {
    final form = _formKey.currentState;
    if(form?.validate() ?? false) {
      return;
    }
    final name = _nameController.text;
    final password = _passwordController.text;
    //banker = BankAccount(name,password);
    BankAccount banker = BankAccount(name,password);

    banker.username = name;
    banker.password = password;
    if(differentUser(banker))
    {
      bank.add(banker);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => DepositPage(name: banker.username, password: banker.password),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding:  const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(

              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (text) =>
              text!.isEmpty? 'Enter Username': null,
            ),
            TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (text) {
                  if(text!.isEmpty) {
                    return 'Enter Password.';
                  }
                  final regex = RegExp('[^@]+@[^.]+..+');
                  if(!regex.hasMatch(text)){
                    return 'Enter a valid Username';
                  }
                  return null;
                }
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validate,
              child: const Text('Continue'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(

                      builder: (_) => AdminPage()
                  ),
                );
              },
              child: Text('Administrator'),
            ),
          ],
        ),
      ),
    );
  }



  @override
  void dispose() {
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }


}
