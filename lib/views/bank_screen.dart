import 'package:broadway_example_ui/brains/bank_account.dart';
import 'package:flutter/material.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  TextEditingController depositcontroller = TextEditingController();
  TextEditingController withDrawController = TextEditingController();



  BankAccount bankAccount = BankAccount("Prabesh", 1000);
  
  String myBalance = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text("Bank Screen")),
      body: Column(
        children: [
          TextField(
            controller: depositcontroller,
            decoration: InputDecoration(
              label: Text("Enter deposit amount"),
              prefixIcon: Icon(Icons.add),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              double amount = double.parse(depositcontroller.text);
              bankAccount.deposit(amount);
              setState(() {
                myBalance = bankAccount.balance.toString();
              });

              print("My balance is $myBalance");
            },
            child: Text("Deposit"),
          ),

          TextField(
            controller: withDrawController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text("Enter withDraw amount"),
              prefixIcon: Icon(Icons.remove),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              double amount = double.parse(withDrawController.text);
              bankAccount.withdraw(amount);
              setState(() {
                myBalance = bankAccount.balance.toString();
              });
            },
            child: Text("WithDraw"),
          ),

          Text("My Balance is $myBalance"),
        ],
      ),
    );
  }
}
