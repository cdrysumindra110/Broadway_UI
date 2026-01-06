import 'package:broadway_example_ui/animation_screen.dart';
import 'package:broadway_example_ui/avatars/avatar_screen.dart';
import 'package:broadway_example_ui/counter%20with%20bloc/counter_bloc.dart';
import 'package:broadway_example_ui/counter%20with%20bloc/counter_screen_bloc.dart';
import 'package:broadway_example_ui/counter%20with%20cubit/counter_cubit.dart';
import 'package:broadway_example_ui/counter%20with%20cubit/counter_screen_cubit.dart';
import 'package:broadway_example_ui/expenses_tracker.dart';
import 'package:broadway_example_ui/for%20firebase/user_firebase_screen.dart';
import 'package:broadway_example_ui/login%20with%20bloc/login_bloc.dart';
import 'package:broadway_example_ui/login%20with%20bloc/login_screen_bloc.dart';
import 'package:broadway_example_ui/login%20with%20cubit/login_cubit.dart';
import 'package:broadway_example_ui/login%20with%20cubit/login_screen_cubit.dart';
import 'package:broadway_example_ui/login_screen.dart';
import 'package:broadway_example_ui/mobile/mobile_screen.dart';
import 'package:broadway_example_ui/next_screen.dart';
import 'package:broadway_example_ui/note/note_screen.dart';
import 'package:broadway_example_ui/provider/counter_provider.dart';
import 'package:broadway_example_ui/provider/counter_screen_with_provider.dart';
import 'package:broadway_example_ui/provider/counter_screen_without.dart';
import 'package:broadway_example_ui/provider/task_provider.dart';
import 'package:broadway_example_ui/provider/theme_provider.dart';
import 'package:broadway_example_ui/theme_bloc.dart';
import 'package:broadway_example_ui/todo/todo_screen.dart';
import 'package:broadway_example_ui/users/user_bloc.dart';
import 'package:broadway_example_ui/users/user_screen.dart';
import 'package:broadway_example_ui/users/user_service.dart';
import 'package:broadway_example_ui/views/bmi_calculator_screen.dart';
import 'package:broadway_example_ui/weather/weather_bloc.dart';
import 'package:broadway_example_ui/weather/weather_brain.dart';
import 'package:broadway_example_ui/weather/weather_provider.dart';
import 'package:broadway_example_ui/weather/weather_screen.dart';
import 'package:broadway_example_ui/weather/weather_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => UserBloc(UserService())),
        BlocProvider(
          create: (_) => WeatherBloc(WeatherService(), WeatherBrain()),
        ),
        // ChangeNotifierProvider(create: (_) => CounterProvider()),
        // ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // ChangeNotifierProvider(create: (_) => TaskProvider()),
        // ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          themeMode: state,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: FirebaseUser(),
        );
      },
    );
  }
}

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   String result = '';

//   void login() {
//     if (emailController.text.contains('@')) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(user: emailController.text),
//         ),
//       );
//       setState(() {
//         result = '';
//       });
//     } else {
//       setState(() {
//         result = 'Invalid Email';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           TextFormField(controller: emailController),
//           ElevatedButton(
//             onPressed: () {
//               login();
//             },
//             child: Text('Login'),
//           ),
//           Text(result),
//         ],
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // final String user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("welcome"),
      //  Column(
      //   children: [
      //     // Text('Welcome $user'),
      //     // ElevatedButton(
      //     //   onPressed: () {
      //     //     Navigator.pop(context);
      //     //   },
      //     //   child: Text("Logout"),
      //     // ),
      //   ],
      // ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("$count"),
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: Text("Add"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Text("Next"),
          ),
        ],
      ),
    );
  }
}
// user: 'user'
// class EmailField extends StatelessWidget {
//   const EmailField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: TextField(key: Key("email")));
//   }
// }
// String validate(int age) {
//   if (age < 18) {
//     return "Underage";
//   }
//   return "Allowed";
// }

// bool isEven(int number) {
//   return number % 2 == 0;
// }

// double priceWithTax(double price) {
//   return price + (price * 0.13);
// }
