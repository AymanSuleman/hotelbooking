import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotelbooking/signin.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Signup(),
  ));
}

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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerUser() async {
    setState(() {
      _termsError = !_agreeToTerms;
    });

    if (_formKey.currentState!.validate() && _agreeToTerms) {
      setState(() {
        _isLoading = true;
      });

      final url = Uri.parse("http://192.168.0.36:5000/api/auth/register");

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

        if (response.statusCode == 201) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        } else {
          _showAlert(responseBody["msg"] ?? "Registration failed!");
        }
      } catch (e) {
        _showAlert("Error: ${e.toString()}");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Message"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
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

              // Name Input
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

              // Email Input
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

              // Password Input
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

              // Terms and Conditions Checkbox
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
                    onTap: () {}, // Handle Terms & Conditions action
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

              // Sign Up Button
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

              // Or sign up with
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

              // Social Media Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialMediaButton(FontAwesomeIcons.facebook, "Facebook"),
                  SizedBox(width: 16),
                  socialMediaButton(FontAwesomeIcons.google, "Google"),
                  SizedBox(width: 16),
                  socialMediaButton(FontAwesomeIcons.instagram, "Instagram"),
                ],
              ),
              SizedBox(height: 24),

              // Already have an account? Sign In
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

  // Social Media Button
  Widget socialMediaButton(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        print('$label clicked');
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(
          icon,
          size: 30,
          color: Colors.blue,
        ),
      ),
    );
  }
}
