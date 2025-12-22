import 'dart:math';

import 'package:broadway_example_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Counter flow", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.widgetWithText(ElevatedButton, "Add"));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
  });
  // testWidgets('Full login flow', (WidgetTester tester) async {
  //   //invalid email
  //   await tester.pumpWidget(MyApp());
  //   await tester.enterText(find.byType(TextFormField), 'abc');
  //   await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
  //   await tester.pumpAndSettle();
  //   expect(find.text('Invalid Email'), findsOneWidget);

  //   //valid email
  //   await tester.enterText(find.byType(TextFormField), 'abc@test.com');
  //   await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
  //   await tester.pumpAndSettle();
  //   expect(find.text('Welcome abc@test.com'), findsOneWidget);
  //   //logout
  //   await tester.tap(find.widgetWithText(ElevatedButton, 'Logout'));
  //   await tester.pumpAndSettle();
  //   expect(find.text('Invalid Email'), findsNothing);
  //   expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  // });
}
