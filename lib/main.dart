import 'package:flutter/material.dart';
import 'package:hotelbooking/home.dart';
import 'package:hotelbooking/locationAdd.dart';
import 'package:hotelbooking/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('token');
  String? savedUserId = prefs.getString('userId');
  bool isLoggedIn = token != null && savedUserId != null;

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    savedUserId: savedUserId,
    isRemembered: true,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? savedUserId;

  const MyApp({
    required this.isLoggedIn,
    this.savedUserId,
    required bool isRemembered,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn
          ? HomeScreen12(
              userId: savedUserId!,
            )
          // HomeScreen(userId: savedUserId!)
          : SignInScreen(), // No need for email/password here
    );
  }
}
