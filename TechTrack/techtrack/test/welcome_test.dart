import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:techtrack/screens/welcome_screen.dart';

void main() {
  testWidgets('UI Test WelcomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: WelcomeScreen(),
    ));

    final getStartedButtonFinder = find.text('Get Started');
    final loginButtonFinder = find.text('Login');
    final welcomeTextFinder = find.text("Let's get started!");
    final descriptionTextFinder = find.text("Never a better time than now to start");

    expect(getStartedButtonFinder, findsOneWidget);
    expect(loginButtonFinder, findsOneWidget);
    expect(welcomeTextFinder, findsOneWidget);
    expect(descriptionTextFinder, findsOneWidget);
  });
}
