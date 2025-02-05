
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hotelbooking/myprofile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // children: [
            //   CircleAvatar(
            //     radius: 50,
            //     backgroundImage: AssetImage("assets/profile.jpg"),
            //   ),
            children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile.jpg"),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Handle profile picture update
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.edit, size: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
              SizedBox(height: 10),
              Text(
                "Antony William",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("AntonyWilliam12@gmail.com"),
              SizedBox(height: 20),
              buildListTile(context, Icons.person, "Personal Info",MyProfile()),
              buildListTile(context, Icons.lock, "Privacy & Sharing"),
              buildListTile(context, Icons.notifications, "Notification", NotificationScreen()),
              buildListTile(context, Icons.reviews, "Review"),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Log Out", style: TextStyle(color: Colors.red)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, IconData icon, String title, [Widget? page]) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: page != null
          ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => page))
          : null,
    );
  }
}

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool pushNotification = true;
  bool emailNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildSwitchTile("Push Notification", pushNotification, (val) {
              setState(() => pushNotification = val);
            }),
            buildSwitchTile("Email", emailNotification, (val) {
              setState(() => emailNotification = val);
            }),
          ],
        ),
      ),
    );
  }

  Widget buildSwitchTile(String title, bool status, Function(bool) onChanged) {
    return ListTile(
      title: Text(title),
      trailing: FlutterSwitch(
        width: 50.0,
        height: 25.0,
        value: status,
        onToggle: onChanged,
      ),
    );
  }
}