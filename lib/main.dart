import 'package:broadway_example_ui/avatars/avatar_screen.dart';
import 'package:broadway_example_ui/expenses_tracker.dart';
import 'package:broadway_example_ui/mobile/mobile_screen.dart';
import 'package:broadway_example_ui/users/user_screen.dart';
import 'package:broadway_example_ui/views/bmi_calculator_screen.dart';
import 'package:broadway_example_ui/weather/weather_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AvatarScreen());
  }
}
//main -runApp-- (material)Stateless-- > scaffold(screen)