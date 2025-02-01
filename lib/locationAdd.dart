import 'package:flutter/material.dart';
import 'package:hotelbooking/home.dart';
import 'package:hotelbooking/manuallyLocationAdd.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LocationScreen(),
  ));
}

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            // Location Icon
            Icon(
              Icons.location_on,
              size: 80,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            // Title
            Text(
              "What is Your Location?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "We need to know your location in order to suggest nearby services.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 30),
            // Allow Location Access Button
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle location permission request
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Allow Location Access",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Enter Location Manually Button
            TextButton(
              onPressed: () {
                // Navigate to manual location input screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnterLocationScreen(),
                    ));
              },
              child: Text(
                "Enter Location Manually",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
