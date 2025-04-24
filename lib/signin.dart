// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hotelbooking/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hotelbooking/change_pass.dart';
// import 'package:hotelbooking/locationAdd.dart';
// import 'package:hotelbooking/signup.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool isRemembered = prefs.getBool('remember_me') ?? false;
//   String? savedEmail = prefs.getString('email');
//   String? savedPassword = prefs.getString('password');

//   runApp(MyApp(
//     isRemembered: isRemembered,
//     savedEmail: savedEmail,
//     savedPassword: savedPassword,
//   ));
// }

// class MyApp extends StatelessWidget {
//   final bool isRemembered;
//   final String? savedEmail;
//   final String? savedPassword;

//   MyApp({required this.isRemembered, this.savedEmail, this.savedPassword});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignInScreen(
//         isRemembered: isRemembered,
//         savedEmail: savedEmail,
//         savedPassword: savedPassword,
//       ),
//     );
//   }
// }

// class SignInScreen extends StatefulWidget {
//   final bool isRemembered;
//   final String? savedEmail;
//   final String? savedPassword;

//   SignInScreen(
//       {this.isRemembered = false, this.savedEmail, this.savedPassword});

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
//   bool rememberMe = false;

//   @override
//   void initState() {
//     super.initState();
//     rememberMe = widget.isRemembered;
//     if (widget.isRemembered) {
//       emailController.text = widget.savedEmail ?? '';
//       passwordController.text = widget.savedPassword ?? '';
//     }
//   }

//   Future<void> _signIn() async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       _showErrorDialog("Please enter both email and password.");
//       return;
//     }

//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.0.50:5000/api/auth/login'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": email, "password": password}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final token = data['token'];
//         final user = data['user'];

//         // Store login info if rememberMe is checked
//         if (rememberMe) {
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setBool('remember_me', true);
//           await prefs.setString('email', email);
//           await prefs.setString('password', password);
//         }

//         // You may want to save the token if needed
//         // Example: await prefs.setString('token', token);

//         // Navigate to next screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//         );
//       } else {
//         final errorData = jsonDecode(response.body);
//         _showErrorDialog(errorData['msg'] ?? 'Login failed');
//       }
//     } catch (e) {
//       print("Login error: $e"); // Add this
//       _showErrorDialog("Something went wrong. Please try again later.");
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Login Error'),
//         content: Text(message),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context), child: Text('OK')),
//         ],
//       ),
//     );
//   }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.white,
//     body: SafeArea(
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minHeight: constraints.maxHeight),
//               child: IntrinsicHeight(
//                 child: Padding(
//                   padding: EdgeInsets.all(20.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Spacer(),
//                       Center(
//                         child: Text(
//                           "Sign In",
//                           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Center(
//                         child: Text(
//                           "Hi! Welcome back, you've been missed",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(height: 30),
//                       Text("Email"),
//                       TextField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           hintText: "example@gmail.com",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Text("Password"),
//                       ValueListenableBuilder(
//                         valueListenable: obscurePassword,
//                         builder: (context, value, child) {
//                           return TextField(
//                             controller: passwordController,
//                             obscureText: value,
//                             decoration: InputDecoration(
//                               hintText: "Enter your password",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   value ? Icons.visibility_off : Icons.visibility,
//                                 ),
//                                 onPressed: () {
//                                   obscurePassword.value = !value;
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: rememberMe,
//                                 onChanged: (bool? value) {
//                                   setState(() {
//                                     rememberMe = value ?? false;
//                                   });
//                                 },
//                               ),
//                               Text("Remember Me"),
//                             ],
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => ChangePass()),
//                               );
//                             },
//                             child: Text(
//                               "Forgot Password?",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _signIn,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Text(
//                             "Sign In",
//                             style: TextStyle(fontSize: 16, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Center(child: Text("Or sign in with")),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           socialButton(FontAwesomeIcons.facebook),
//                           SizedBox(width: 20),
//                           socialButton(FontAwesomeIcons.google),
//                           SizedBox(width: 20),
//                           socialButton(FontAwesomeIcons.instagram),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       Center(
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => Signup()),
//                             );
//                           },
//                           child: Text(
//                             "Don't have an account? Sign Up",
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }
// }

//   Widget socialButton(IconData icon) {
//     return GestureDetector(
//       onTap: () {
//         print('$icon clicked');
//       },
//       child: Container(
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: Colors.grey.shade300)),
//         child: Icon(icon, size: 30, color: Colors.blue),
//       ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotelbooking/home.dart';
import 'package:hotelbooking/change_pass.dart';
import 'package:hotelbooking/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  final bool isRemembered;
  final String? savedEmail;
  final String? savedPassword;

  SignInScreen({
    this.isRemembered = false,
    this.savedEmail,
    this.savedPassword,
  });

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
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Please enter both email and password.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.26:5000/api/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = data['user'];
        final userId = user['id']; // ✅ Extract MongoDB user ID

        SharedPreferences prefs = await SharedPreferences.getInstance();

        // ✅ Save userId
        await prefs.setString('userId', userId);

        // ✅ Save credentials if "Remember Me" is checked
        if (rememberMe) {
          await prefs.setBool('remember_me', true);
          await prefs.setString('email', email);
          await prefs.setString('password', password);
        }

        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
        );
      } else {
        final errorData = jsonDecode(response.body);
        _showErrorDialog(errorData['msg'] ?? 'Login failed');
      }
    } catch (e) {
      print("Login error: $e");
      _showErrorDialog("Something went wrong. Please try again later.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
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
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePass()),
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.black),
                              ),
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Sign In",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
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
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                            child: Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
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
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300)),
        child: Icon(icon, size: 30, color: Colors.blue),
      ),
    );
  }
}
