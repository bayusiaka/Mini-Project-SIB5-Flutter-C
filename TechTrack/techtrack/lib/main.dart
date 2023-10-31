import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtrack/providers/bookmark_providers.dart';
import 'package:techtrack/providers/smartphone_providers.dart';
import 'package:techtrack/screens/bookmark_screen.dart';
import 'package:techtrack/screens/techtalkai_screen.dart';
import 'package:techtrack/screens/home_screen.dart';
import 'package:techtrack/screens/login_screen.dart';
import 'package:techtrack/screens/profile_screen.dart';
import 'package:techtrack/screens/signup_screen.dart';
import 'package:techtrack/providers/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:techtrack/screens/welcome_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthenticationService>(
        create: (context) => AuthenticationService(),
      ),
      ChangeNotifierProvider<BookmarkProvider>(
        create: (context) => BookmarkProvider(),
      ),
      ChangeNotifierProvider<SmartphoneRecommendationProvider>(
        create: (context) => SmartphoneRecommendationProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TechTrack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(67, 176, 255, 1)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(username: ''),
        '/bookmark': (context) => const BookmarkScreen(),
        '/techtalk': (context) => const SmartphoneRecommendationScreen(),
        '/profile': (context) => const ProfileScreen(username: ''),
      },
    );
  }
}