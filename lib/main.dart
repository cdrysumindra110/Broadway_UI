import 'package:broadway_example_ui/expenses_tracker.dart';
import 'package:broadway_example_ui/views/bmi_calculator_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpensesTracker(),
    );
  }
}
//main -runApp-- (material)Stateless-- > scaffold(screen)