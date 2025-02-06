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
                          child:
                              Icon(Icons.edit, size: 15, color: Colors.white),
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
              buildListTile(
                  context, Icons.person, "Personal Info", MyProfile()),
              buildListTile(context, Icons.lock, "Privacy & Sharing"),
              buildListTile(context, Icons.notifications, "Notification",
                  NotificationSettingsScreen()),
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

  ListTile buildListTile(BuildContext context, IconData icon, String title,
      [Widget? page]) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: page != null
          ? () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => page))
          : null,
    );
  }
}

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool pushTips = true;
  bool emailTips = true;
  bool pushActivity = true;
  bool emailActivity = true;
  bool pushReminders = true;
  bool emailReminders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Notification", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
                "SPECIAL TIPS AND OFFERS",
                pushTips,
                emailTips,
                (val) => setState(() => pushTips = val),
                (val) => setState(() => emailTips = val)),
            _buildSection(
                "ACTIVITY",
                pushActivity,
                emailActivity,
                (val) => setState(() => pushActivity = val),
                (val) => setState(() => emailActivity = val)),
            _buildSection(
                "REMINDERS",
                pushReminders,
                emailReminders,
                (val) => setState(() => pushReminders = val),
                (val) => setState(() => emailReminders = val)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, bool pushValue, bool emailValue,
      Function(bool) onPushChanged, Function(bool) onEmailChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          SizedBox(height: 10),
          _buildToggle("Push Notification", pushValue, onPushChanged),
          _buildToggle("Email", emailValue, onEmailChanged),
        ],
      ),
    );
  }

  Widget _buildToggle(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
