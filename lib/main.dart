// import 'package:flutter/material.dart';
// import 'package:hotelbooking/home.dart';
// import 'package:hotelbooking/locationAdd.dart';
// import 'package:hotelbooking/signin.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   String? token = prefs.getString('token');
//   String? savedUserId = prefs.getString('userId');
//   bool isLoggedIn = token != null && savedUserId != null;

//   runApp(MyApp(
//     isLoggedIn: isLoggedIn,
//     savedUserId: savedUserId,
//     isRemembered: true,
//   ));
// }

// class MyApp extends StatelessWidget {
//   final bool isLoggedIn;
//   final String? savedUserId;

//   const MyApp({
//     required this.isLoggedIn,
//     this.savedUserId,
//     required bool isRemembered,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: isLoggedIn
//           ? HomeScreen12(
//               userId: savedUserId!,
//             )
//           // HomeScreen(userId: savedUserId!)
//           : SignInScreen(), // No need for email/password here
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelbooking/locationAdd.dart';
// import 'home_screen.dart';

void main() => runApp(const HotelApp());

class HotelApp extends StatelessWidget {
  const HotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF4D5DFA); // Accent Blue
    const secondary = Color(0xFF7B61FF); // Purple
    const bg = Color(0xFFF9F9F9);
    const textDark = Color(0xFF1C1C1C);
    const textLight = Color(0xFF8C8C8C);

    final baseText = GoogleFonts.poppins();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking',
      theme: ThemeData(
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          primary: primary,
          secondary: secondary,
          surface: Colors.white,
        ),
        textTheme: TextTheme(
          titleLarge: baseText.copyWith(
              fontSize: 20, fontWeight: FontWeight.w600, color: textDark),
          titleMedium: baseText.copyWith(
              fontSize: 16, fontWeight: FontWeight.w600, color: textDark),
          bodyMedium: baseText.copyWith(fontSize: 14, color: textDark),
          bodySmall: baseText.copyWith(fontSize: 12, color: textLight),
          labelLarge: baseText.copyWith(
              fontSize: 14, fontWeight: FontWeight.w600, color: primary),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // <-- only the HomeScreen here
    );
  }
}
