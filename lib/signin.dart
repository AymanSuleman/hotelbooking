// import 'package:flutter/material.dart';
// import 'package:hotelbooking/home.dart';
// import 'package:hotelbooking/signup.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({Key? key}) : super(key: key);

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Welcome back!',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 15),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.visibility_off),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => HomeScreen(),
//                       ));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                 ),
//                 child: Text(
//                   'Sign In',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Don't have an account? "),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Signup()),
//                       );
//                     },
//                     child: Text(
//                       "Sign Up here",
//                       style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hotelbooking/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> obscurePassword = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Sign In",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Hi! Welcome back, you've been missed",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),

            // Email Field
            const Text("Email"),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "example@gmail.com",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            // Password Field
            const Text("Password"),
            ValueListenableBuilder(
              valueListenable: obscurePassword,
              builder: (context, value, child) {
                return TextField(
                  controller: passwordController,
                  obscureText: value,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      icon:
                          Icon(value ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        obscurePassword.value = !value;
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
            ),
            const SizedBox(height: 20),

            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Sign In",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),

            // Social Sign In
            const Center(child: Text("Or sign in with")),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialButton("assets/images/facebook.png"),
                const SizedBox(width: 20),
                socialButton("assets/google.jpeg"),
                const SizedBox(width: 20),
                socialButton("assets/instagram.jpeg"),
              ],
            ),
            const SizedBox(height: 20),

            // Sign Up
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Don't have an account? Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialButton(String assetPath) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Image.asset(assetPath, width: 25), // Add images in assets/
        ),
      ),
    );
  }
}
