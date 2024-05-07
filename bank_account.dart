import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kalkulate_app/login_screen.dart';
//Upon Enter initialize Object of username and password.
// Associate deposits following with the Bank account Object.
//Savings or Checkings Option
//Important to track uses.

class BankAccount {
   String username;
   String password;

  BankAccount(this.username, this.password)
      : Savings = Banking(0),
        Checkings = Banking(0); //Will assume that first name and last are provided and will create an object for you.

  Banking Savings;
  Banking Checkings;

  void transfer(bool stc, double amount)
  {
    if(stc)
    {
      Savings.transact(amount);
      Checkings.deposit(amount);

    }
    else
    {
      Checkings.transact(amount);
      Savings.deposit(amount);
    }
  }
  @override
  String toString() {
    return '$username $password';
  }
}

class Banking {
  Banking(this.Balance);
  double Balance;

  double deposit(double x) => Balance = Balance + x;

  double transact(double x) => Balance = Balance - x;


}

List<BankAccount> bank =[];

int userIndex = 1;
bool differentUser(BankAccount testAccount)
{
  for (int i = 0; i < bank.length; i++)
    {
      if (testAccount.username==bank[i].username && testAccount.password == bank[i].password) {
        userIndex = i;
        return false;
      }

    }
  userIndex = bank.length;
   if(userIndex < 0) {
     userIndex = 0;
   }
  return true;
}
