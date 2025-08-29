import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'signin.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscurePassword = true;
  bool _agreeToTerms = false;
  bool _termsError = false;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final String apiBaseUrl = "http://192.168.0.32:5000/api/auth";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// ✅ Register User with API
  Future<void> registerUser() async {
    setState(() {
      _termsError = !_agreeToTerms;
    });

    if (_formKey.currentState!.validate() && _agreeToTerms) {
      setState(() {
        _isLoading = true;
      });

      final url = Uri.parse("$apiBaseUrl/register");

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": nameController.text.trim(),
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
          }),
        );

        final responseBody = jsonDecode(response.body);
        print("📩 Signup API Response: $responseBody"); // Debugging

        if (response.statusCode == 201) {
          // ✅ Extract userId from response
          String userId = responseBody['user']?['_id']?.toString() ?? '';
          String name = responseBody['user']?['name']?.toString() ?? '';

          // ✅ Save to SharedPreferences
          if (userId.isNotEmpty) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('userId', userId);
            print("✅ UserId saved after signup: $userId");
          } else {
            print("❌ UserId not found in response");
          }

          Fluttertoast.showToast(
            msg: "Welcome, $name!",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          // ✅ Directly go to Home instead of SignIn
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        } else {
          Fluttertoast.showToast(
            msg: responseBody["msg"] ?? "Registration failed!",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error: ${e.toString()}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// ✅ Google Sign-In (Send to MongoDB API)
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        Fluttertoast.showToast(msg: "Google sign-in cancelled");
        return;
      }

      final String email = googleUser.email;
      final String name = googleUser.displayName ?? "";
      final String photoUrl = googleUser.photoUrl ?? "";

      final url = Uri.parse("$apiBaseUrl/social-login");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "photo": photoUrl,
          "provider": "google"
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Logged in as $name",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SignInScreen()));
      } else {
        Fluttertoast.showToast(
          msg: responseBody["msg"] ?? "Google login failed!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Google Sign-in Error: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  /// ✅ Facebook Sign-In (Send to MongoDB API)
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        final name = userData['name'] ?? '';
        final email = userData['email'] ?? '';
        final photo = userData['picture']['data']['url'] ?? '';

        final url = Uri.parse("$apiBaseUrl/social-login");
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": name,
            "email": email,
            "photo": photo,
            "provider": "facebook"
          }),
        );

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: "Logged in as $name",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SignInScreen()));
        } else {
          Fluttertoast.showToast(
            msg: responseBody["msg"] ?? "Facebook login failed!",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(msg: "Facebook login cancelled");
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Facebook Login Error: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  "Fill your information below or register\nwith your social account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 24),
              Text("Name"),
              SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                decoration: _inputDecoration("John Doe"),
                validator: (value) => value == null || value.trim().isEmpty
                    ? "Name is required"
                    : null,
              ),
              SizedBox(height: 16),
              Text("Email"),
              SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                decoration: _inputDecoration("example@gmail.com"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                      .hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text("Password"),
              SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: _inputDecoration("****").copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 6) {
                    return "Minimum 6 characters required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                        _termsError = !_agreeToTerms;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  Text("Agree with "),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Terms & Condition",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              if (_termsError)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "You must agree to the Terms & Conditions.",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _isLoading ? null : registerUser,
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Sign Up",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Or sign up with"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialMediaButton(FontAwesomeIcons.google, signInWithGoogle),
                  SizedBox(width: 16),
                  socialMediaButton(
                      FontAwesomeIcons.facebook, signInWithFacebook),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialMediaButton(IconData icon, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(12),
        // decoration: BoxDecoration(
        //   shape: BoxShape.circle,
        //   border: Border.all(color: Colors.grey.shade300),
        // ),
        child: Icon(
          icon,
          size: 30,
          color: Colors.blue,
        ),
      ),
    );
  }
}
