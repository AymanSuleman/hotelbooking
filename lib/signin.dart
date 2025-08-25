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
