import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_loginpage/main.dart';

void main() {
  testWidgets('MyLoginApp loads and displays login screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyLoginApp());

    expect(find.text('Flutter Navigation Demo'), findsOneWidget);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register New Account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('Navigation to Register screen and back works',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyLoginApp());

    // Tap Register button
    await tester.tap(find.text('Register New Account'));
    await tester.pumpAndSettle();

    // Verify on Register screen
    expect(find.widgetWithText(AppBar, 'Register Account'), findsOneWidget);
    expect(find.text('Create New Account'), findsOneWidget);

    // Tap back button
    await tester.tap(find.byTooltip('Back to Login'));
    await tester.pumpAndSettle();

    // Verify back on Login screen
    expect(find.text('Welcome Back'), findsOneWidget);
  });

  testWidgets(
      'Login routes directly to Dashboard, supports 4-tab bottom navigation & Profile',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyLoginApp());

    // Tap the autofill demo button
    await tester.tap(find.text('Autofill demo (admin / 1234)'));
    await tester.pumpAndSettle();

    // Tap Login
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    // Verify post-login screen is DASHBOARD (and NOT notification)
    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Welcome, admin!'), findsOneWidget);
    expect(find.text('Quick Navigation Hub'), findsOneWidget);

    // Test Navigation from Dashboard quick card to Notifications tab
    await tester.tap(find.text('Notifications').first);
    await tester.pumpAndSettle();

    // Verify now on Notifications section
    expect(find.widgetWithText(AppBar, 'Notifications'), findsOneWidget);
    expect(find.text('Mobile Programming Class Update'), findsOneWidget);

    // Test Bottom Navigation to Contacts
    await tester.tap(find.text('Contacts'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Contacts Directory'), findsOneWidget);
    expect(find.text('Alex Rivera'), findsOneWidget);

    // Test Bottom Navigation to Profile
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'My Profile'), findsOneWidget);
    expect(find.text('Administrator'), findsOneWidget);
    expect(find.text('@admin'), findsOneWidget);
    expect(find.text('Edit Profile'), findsNothing); // Dialog not opened yet

    // Test logout dialog from AppBar
    await tester.tap(find.byTooltip('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Confirm Logout'), findsOneWidget);

    // Confirm logout
    await tester.tap(find.widgetWithText(ElevatedButton, 'Logout'));
    await tester.pumpAndSettle();

    // Verify back on Login screen
    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
