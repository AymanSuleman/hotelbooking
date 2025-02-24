import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotelbooking/signin.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Signup(),
//   ));
// }

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
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
            TextField(
              decoration: InputDecoration(
                hintText: "John Doe",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 16),

            // Email Input
            Text("Email"),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: "example@gmail.com",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 16),

            // Password Input
            Text("Password"),
            SizedBox(height: 8),
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: "****",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ));
                },
                child: Text("Sign Up",
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
                onTap: () {}, // Handle Sign In navigation
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
    );
  }

  // Social Media Button
  Widget socialMediaButton(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        // Add your social media signup logic here
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
          color: Colors.blue, // Change to preferred color
        ),
      ),
    );
  }
}
