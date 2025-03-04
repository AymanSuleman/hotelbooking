// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hotelbooking/change_pass.dart';
// // import 'package:hotelbooking/home.dart';
// import 'package:hotelbooking/locationAdd.dart';
// import 'package:hotelbooking/signup.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignInScreen(),
//     );
//   }
// }

// class SignInScreen extends StatelessWidget {
//   SignInScreen({super.key});

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final ValueNotifier<bool> obscurePassword = ValueNotifier(true);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Text(
//                 "Sign In",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 10),
//             Center(
//               child: Text(
//                 "Hi! Welcome back, you've been missed",
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             SizedBox(height: 30),

//             // Email Field
//             Text("Email"),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 hintText: "example@gmail.com",
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Password Field
//             Text("Password"),
//             ValueListenableBuilder(
//               valueListenable: obscurePassword,
//               builder: (context, value, child) {
//                 return TextField(
//                   controller: passwordController,
//                   obscureText: value,
//                   decoration: InputDecoration(
//                     hintText: "Enter your password",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     suffixIcon: IconButton(
//                       icon:
//                           Icon(value ? Icons.visibility_off : Icons.visibility),
//                       onPressed: () {
//                         obscurePassword.value = !value;
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 10),

//             // Forgot Password
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   // Navigate to forgot password page
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => ChangePass()));
//                 },
//                 child: Text("Forgot Password?",style: TextStyle(color: Colors.black),),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Sign In Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LocationScreen(),
//                       ));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: Text("Sign In",
//                     style: TextStyle(fontSize: 16, color: Colors.white)),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Social Sign In
//             Center(child: Text("Or sign in with")),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 socialButton(FontAwesomeIcons.facebook, "Facebook"),
//                 SizedBox(width: 20),
//                 socialButton(FontAwesomeIcons.google, "Google"),
//                 SizedBox(width: 20),
//                 socialButton(FontAwesomeIcons.instagram, "Instagram"),
//               ],
//             ),
//             SizedBox(height: 20),

//             // Sign Up
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Signup()));
//                 },
//                 child: RichText(
//                   text: TextSpan(
//                     text: "Don't have an account? ",
//                     style: TextStyle(color: Colors.black),
//                     children: [
//                       TextSpan(
//                         text: "Sign Up",
//                         style: TextStyle(
//                             color: Colors.blue, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget socialButton(IconData icon, String label) {
//     return GestureDetector(
//       onTap: () {
//         // Add your social media signup logic here
//         print('$label clicked');
//       },
//       child: Container(
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Icon(
//           icon,
//           size: 30,
//           color: Colors.blue, // Change to preferred color
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotelbooking/change_pass.dart';
import 'package:hotelbooking/locationAdd.dart';
import 'package:hotelbooking/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isRemembered = prefs.getBool('remember_me') ?? false;
  String? savedEmail = prefs.getString('email');
  String? savedPassword = prefs.getString('password');

  runApp(MyApp(
    isRemembered: isRemembered,
    savedEmail: savedEmail,
    savedPassword: savedPassword,
  ));
}

class MyApp extends StatelessWidget {
  final bool isRemembered;
  final String? savedEmail;
  final String? savedPassword;

  MyApp({required this.isRemembered, this.savedEmail, this.savedPassword});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(
        isRemembered: isRemembered,
        savedEmail: savedEmail,
        savedPassword: savedPassword,
      ),
    );
  }
}

class SignInScreen extends StatefulWidget {
  final bool isRemembered;
  final String? savedEmail;
  final String? savedPassword;

  SignInScreen({this.isRemembered = false, this.savedEmail, this.savedPassword});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    rememberMe = widget.isRemembered;
    if (widget.isRemembered) {
      emailController.text = widget.savedEmail ?? '';
      passwordController.text = widget.savedPassword ?? '';
    }
  }

  Future<void> _signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setBool('remember_me', true);
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
    } else {
      await prefs.remove('remember_me');
      await prefs.remove('email');
      await prefs.remove('password');
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Sign In",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Hi! Welcome back, you've been missed",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 30),
            Text("Email"),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "example@gmail.com",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),
            Text("Password"),
            ValueListenableBuilder(
              valueListenable: obscurePassword,
              builder: (context, value, child) {
                return TextField(
                  controller: passwordController,
                  obscureText: value,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      icon: Icon(value ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        obscurePassword.value = !value;
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),
                    Text("Remember Me"),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ChangePass()));
                  },
                  child: Text("Forgot Password?", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Sign In", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Center(child: Text("Or sign in with")),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialButton(FontAwesomeIcons.facebook),
                SizedBox(width: 20),
                socialButton(FontAwesomeIcons.google),
                SizedBox(width: 20),
                socialButton(FontAwesomeIcons.instagram),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialButton(IconData icon) {
    return GestureDetector(
      onTap: () {
        print('$icon clicked');
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
        child: Icon(icon, size: 30, color: Colors.blue),
      ),
    );
  }
}
