// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // User Profile Section
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundImage:
//                       NetworkImage('https://i.stack.imgur.com/l60cH.png'),
//                 ),
//                 const SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Elaine Edwards',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'elaine.edwards@google.com',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32),

//             // Dark Mode Switch
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Switch to Dark Mode'),
//                 Switch(
//                   value: false, // Assuming dark mode is off
//                   onChanged: (value) {
//                     // Handle dark mode toggle
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32),

//             // Account Settings Section
//             const Text(
//               'Account Settings',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Change Password Button
//             ElevatedButton(
//               onPressed: () {
//                 // Handle change password action
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 16,
//                 ),
//               ),
//               child: const Text('Change Password'),
//             ),
//             const SizedBox(height: 16),

//             // Logout Button
//             ElevatedButton(
//               onPressed: () {
//                 // Handle logout action
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 16,
//                 ),
//               ),
//               child: const Text('Logout'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hotelbooking/myprofile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: Column(
        children: <Widget>[
          // Profile Section
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Text(
                    'EH',
                    style: TextStyle(fontSize: 40.0, color: Colors.white),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Esther Howard',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Your profile',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ],
            ),
          ),
          Divider(), // Divider between profile and list
          // List of Options
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Your Profile'),
                  onTap: () {
                   
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyProfile(),
                        ));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('Payment Methods'),
                  onTap: () {
                    // Navigate to payment methods screen
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text('My Wallet'),
                  onTap: () {
                    // Navigate to My Wallet page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('My Bookings'),
                  onTap: () {
                    // Navigate to My Bookings page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    // Navigate to Settings page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help Center'),
                  onTap: () {
                    // Navigate to Help Center page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip),
                  title: Text('Privacy Policy'),
                  onTap: () {
                    // Navigate to Privacy Policy page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log out'),
                  onTap: () {
                    // Handle logout
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: ProfileScreen(),
    ));
