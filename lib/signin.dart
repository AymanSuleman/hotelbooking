// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:hotelbooking/home.dart';
// // import 'package:hotelbooking/change_pass.dart';
// // import 'package:hotelbooking/signup.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class SignInScreen extends StatefulWidget {
// //   final bool isRemembered;
// //   final String? savedEmail;
// //   final String? savedPassword;

// //   SignInScreen({
// //     this.isRemembered = false,
// //     this.savedEmail,
// //     this.savedPassword,
// //   });

// //   @override
// //   _SignInScreenState createState() => _SignInScreenState();
// // }

// // class _SignInScreenState extends State<SignInScreen> {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
// //   bool rememberMe = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     rememberMe = widget.isRemembered;
// //     if (widget.isRemembered) {
// //       emailController.text = widget.savedEmail ?? '';
// //       passwordController.text = widget.savedPassword ?? '';
// //     }
// //   }

// //   Future<void> _signIn() async {
// //     final email = emailController.text.trim();
// //     final password = passwordController.text.trim();

// //     if (email.isEmpty || password.isEmpty) {
// //       _showErrorDialog("Please enter both email and password.");
// //       return;
// //     }

// //     try {
// //       final response = await http.post(
// //         Uri.parse('http:// 192.168.0.32:5000/api/auth/login'),
// //         headers: {"Content-Type": "application/json"},
// //         body: jsonEncode({"email": email, "password": password}),
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         final token = data['token'];
// //         final user = data['user'];
// //         final userId = user['id']; // ✅ Extract MongoDB user ID

// //         SharedPreferences prefs = await SharedPreferences.getInstance();

// //         // ✅ Save userId
// //         await prefs.setString('userId', userId);

// //         // ✅ Save credentials if "Remember Me" is checked
// //         if (rememberMe) {
// //           await prefs.setBool('remember_me', true);
// //           await prefs.setString('email', email);
// //           await prefs.setString('password', password);
// //         }

// //         // Navigate to home screen
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
// //         );
// //       } else {
// //         final errorData = jsonDecode(response.body);
// //         _showErrorDialog(errorData['msg'] ?? 'Login failed');
// //       }
// //     } catch (e) {
// //       print("Login error: $e");
// //       _showErrorDialog("Something went wrong. Please try again later.");
// //     }
// //   }

// //   void _showErrorDialog(String message) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text('Login Error'),
// //         content: Text(message),
// //         actions: [
// //           TextButton(
// //               onPressed: () => Navigator.pop(context), child: Text('OK')),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: LayoutBuilder(
// //           builder: (context, constraints) {
// //             return SingleChildScrollView(
// //               child: ConstrainedBox(
// //                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
// //                 child: IntrinsicHeight(
// //                   child: Padding(
// //                     padding: EdgeInsets.all(20.0),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Spacer(),
// //                         Center(
// //                           child: Text(
// //                             "Sign In",
// //                             style: TextStyle(
// //                                 fontSize: 24, fontWeight: FontWeight.bold),
// //                           ),
// //                         ),
// //                         SizedBox(height: 10),
// //                         Center(
// //                           child: Text(
// //                             "Hi! Welcome back, you've been missed",
// //                             style: TextStyle(color: Colors.grey),
// //                           ),
// //                         ),
// //                         SizedBox(height: 30),
// //                         Text("Email"),
// //                         TextField(
// //                           controller: emailController,
// //                           decoration: InputDecoration(
// //                             hintText: "example@gmail.com",
// //                             border: OutlineInputBorder(
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(height: 20),
// //                         Text("Password"),
// //                         ValueListenableBuilder(
// //                           valueListenable: obscurePassword,
// //                           builder: (context, value, child) {
// //                             return TextField(
// //                               controller: passwordController,
// //                               obscureText: value,
// //                               decoration: InputDecoration(
// //                                 hintText: "Enter your password",
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(10),
// //                                 ),
// //                                 suffixIcon: IconButton(
// //                                   icon: Icon(
// //                                     value
// //                                         ? Icons.visibility_off
// //                                         : Icons.visibility,
// //                                   ),
// //                                   onPressed: () {
// //                                     obscurePassword.value = !value;
// //                                   },
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                         ),
// //                         SizedBox(height: 10),
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             Row(
// //                               children: [
// //                                 Checkbox(
// //                                   value: rememberMe,
// //                                   onChanged: (bool? value) {
// //                                     setState(() {
// //                                       rememberMe = value ?? false;
// //                                     });
// //                                   },
// //                                 ),
// //                                 Text("Remember Me"),
// //                               ],
// //                             ),
// //                             TextButton(
// //                               onPressed: () {
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                       builder: (context) => ChangePass()),
// //                                 );
// //                               },
// //                               child: Text(
// //                                 "Forgot Password?",
// //                                 style: TextStyle(color: Colors.black),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         SizedBox(height: 20),
// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: ElevatedButton(
// //                             onPressed: _signIn,
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.blue,
// //                               padding: EdgeInsets.symmetric(vertical: 15),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(10),
// //                               ),
// //                             ),
// //                             child: Text(
// //                               "Sign In",
// //                               style:
// //                                   TextStyle(fontSize: 16, color: Colors.white),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(height: 20),
// //                         Center(child: Text("Or sign in with")),
// //                         SizedBox(height: 10),
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             socialButton(FontAwesomeIcons.facebook),
// //                             SizedBox(width: 20),
// //                             socialButton(FontAwesomeIcons.google),
// //                             SizedBox(width: 20),
// //                             socialButton(FontAwesomeIcons.instagram),
// //                           ],
// //                         ),
// //                         SizedBox(height: 20),
// //                         Center(
// //                           child: TextButton(
// //                             onPressed: () {
// //                               Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                     builder: (context) => Signup()),
// //                               );
// //                             },
// //                             child: Text(
// //                               "Don't have an account? Sign Up",
// //                               style: TextStyle(color: Colors.blue),
// //                             ),
// //                           ),
// //                         ),
// //                         Spacer(),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   Widget socialButton(IconData icon) {
// //     return GestureDetector(
// //       onTap: () {
// //         print('$icon clicked');
// //       },
// //       child: Container(
// //         padding: EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //             shape: BoxShape.circle,
// //             border: Border.all(color: Colors.grey.shade300)),
// //         child: Icon(icon, size: 30, color: Colors.blue),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hotelbooking/home.dart';
// import 'package:hotelbooking/change_pass.dart';
// import 'package:hotelbooking/signup.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class SignInScreen extends StatefulWidget {
//   final bool isRemembered;
//   final String? savedEmail;
//   final String? savedPassword;

//   SignInScreen({
//     this.isRemembered = false,
//     this.savedEmail,
//     this.savedPassword,
//   });

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
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
//     if (!_formKey.currentState!.validate()) return;

//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     try {
//       final response = await http.post(
//         Uri.parse('http:// 192.168.0.32:5000/api/auth/login'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": email, "password": password}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final token = data['token'];
//         final user = data['user'];
//         final userId = user['id'];

//         SharedPreferences prefs = await SharedPreferences.getInstance();

//         if (rememberMe) {
//           await prefs.setBool('remember_me', true);
//           await prefs.setString('email', email);
//           await prefs.setString('password', password);
//         }

//         await prefs.setString('userId', userId);

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
//         );
//       } else {
//         final errorData = jsonDecode(response.body);
//         _showErrorDialog(errorData['msg'] ?? 'Login failed');
//       }
//     } catch (e) {
//       print("Login error: $e");
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
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Padding(
//                     padding: EdgeInsets.all(20.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Spacer(),
//                           Center(
//                             child: Text(
//                               "Sign In",
//                               style: TextStyle(
//                                   fontSize: 24, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Center(
//                             child: Text(
//                               "Hi! Welcome back, you've been missed",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ),
//                           SizedBox(height: 30),
//                           Text("Email"),
//                           TextFormField(
//                             controller: emailController,
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecoration(
//                               hintText: "example@gmail.com",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Email is required';
//                               }
//                               final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
//                               if (!emailRegex.hasMatch(value)) {
//                                 return 'Enter a valid email';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 20),
//                           Text("Password"),
//                           ValueListenableBuilder(
//                             valueListenable: obscurePassword,
//                             builder: (context, value, child) {
//                               return TextFormField(
//                                 controller: passwordController,
//                                 obscureText: value,
//                                 decoration: InputDecoration(
//                                   hintText: "Enter your password",
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       value
//                                           ? Icons.visibility_off
//                                           : Icons.visibility,
//                                     ),
//                                     onPressed: () {
//                                       obscurePassword.value = !value;
//                                     },
//                                   ),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Password is required';
//                                   } else if (value.length < 6) {
//                                     return 'Password must be at least 6 characters';
//                                   }
//                                   return null;
//                                 },
//                               );
//                             },
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Checkbox(
//                                     value: rememberMe,
//                                     onChanged: (bool? value) {
//                                       setState(() {
//                                         rememberMe = value ?? false;
//                                       });
//                                     },
//                                   ),
//                                   Text("Remember Me"),
//                                 ],
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => ChangePass()),
//                                   );
//                                 },
//                                 child: Text(
//                                   "Forgot Password?",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: _signIn,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 padding: EdgeInsets.symmetric(vertical: 15),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: Text(
//                                 "Sign In",
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Center(child: Text("Or sign in with")),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               socialButton(FontAwesomeIcons.facebook),
//                               SizedBox(width: 20),
//                               socialButton(FontAwesomeIcons.google),
//                               SizedBox(width: 20),
//                               socialButton(FontAwesomeIcons.instagram),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Center(
//                             child: TextButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Signup()),
//                                 );
//                               },
//                               child: Text(
//                                 "Don't have an account? Sign Up",
//                                 style: TextStyle(color: Colors.blue),
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget socialButton(IconData icon) {
//     return GestureDetector(
//       onTap: () {
//         print('$icon clicked');
//       },
//       child: Container(
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Icon(icon, size: 30, color: Colors.blue),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'signup.dart';
import 'home.dart';

class SignInScreen extends StatefulWidget {
  final bool isRemembered;
  final String? savedEmail;
  final String? savedPassword;

  SignInScreen(
      {this.isRemembered = false, this.savedEmail, this.savedPassword});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    rememberMe = widget.isRemembered;
    if (widget.isRemembered) {
      emailController.text = widget.savedEmail ?? '';
      passwordController.text = widget.savedPassword ?? '';
    }
  }

  /// ✅ Normal Sign-In
  Future<void> _signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Email and password cannot be empty");
      return;
    }
    if (!RegExp(r'^.+@.+\..+$').hasMatch(email)) {
      Fluttertoast.showToast(msg: "Enter a valid email");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse("http://192.168.0.32:5000/api/auth/login");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('token') && data.containsKey('user')) {
          String userId = data['user']['id']?.toString() ?? '';
          String name = data['user']['name']?.toString() ?? '';

          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (rememberMe) {
            prefs.setBool('isRemembered', true);
            prefs.setString('userId', userId);
            prefs.setString('email', email);
            prefs.setString('password', password);
          } else {
            prefs.remove('isRemembered');
          }

          Fluttertoast.showToast(
            msg: "Welcome back, $name!",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
          );
        } else {
          Fluttertoast.showToast(msg: data['msg'] ?? 'Login failed');
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _isLoading = false);
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  /// ✅ Google Sign-In (Fixed)
  Future<void> _signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(scopes: ['email']);
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Fluttertoast.showToast(msg: "Google sign-in cancelled");
        return;
      }

      Fluttertoast.showToast(
        msg: "Signed in as ${googleUser.email}",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // ✅ Navigate to Home (you can also call your API to register/login)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(userId: googleUser.id)),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: "Google Sign-in Error: $e");
    }
  }

  /// ✅ Facebook Sign-In (Placeholder)
  Future<void> _signInWithFacebook() async {
    Fluttertoast.showToast(
      msg: "Facebook login coming soon",
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              "Sign In",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (val) => setState(() => rememberMe = val!),
                    ),
                    const Text("Remember me"),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    if (emailController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter email to reset password");
                    } else {
                      Fluttertoast.showToast(
                          msg:
                              "Password reset link sent to ${emailController.text}");
                    }
                  },
                  child: const Text("Forgot Password?"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
            const SizedBox(height: 20),
            Text(
              "Or sign in with",
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.google, color: Colors.red),
                  onPressed: _signInWithGoogle,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon:
                      const Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                  onPressed: _signInWithFacebook,
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Signup()));
              },
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
