// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:broadway_example_ui/main.dart';

// void main() {
//   testWidgets("Counter increments", (tester) async {
//     await tester.pumpWidget(MaterialApp(home: Counter()));
//     expect(find.text('0'), findsOneWidget);
//     await tester.tap(find.text("Increment"));
//     await tester.pump();
//     expect(find.text('1'), findsOneWidget);
//   });
//   testWidgets("Enter text in TextField", (tester) async {
//     await tester.pumpWidget(MaterialApp(home: EmailField()));
//     await tester.enterText(find.byKey(Key("email")), "test@gmail.com");
//     await tester.pump();
//     expect(find.text("test@gmail.com"), findsOneWidget);
//   });
// }
