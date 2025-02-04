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

// import 'package:flutter/material.dart';
// import 'package:hotelbooking/myprofile.dart';

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Profile'),
//       ),
//       body: Column(
//         children: <Widget>[
//           // Profile Section
//           Container(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.blue,
//                   child: Text(
//                     'EH',
//                     style: TextStyle(fontSize: 40.0, color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//                 Text(
//                   'Esther Howard',
//                   style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   'Your profile',
//                   style: TextStyle(fontSize: 16.0, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           Divider(), // Divider between profile and list
//           // List of Options
//           Expanded(
//             child: ListView(
//               children: <Widget>[
//                 ListTile(
//                   leading: Icon(Icons.person),
//                   title: Text('Your Profile'),
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MyProfile(),
//                         ));
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.payment),
//                   title: Text('Payment Methods'),
//                   onTap: () {
//                     // Navigate to payment methods screen
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.account_balance_wallet),
//                   title: Text('My Wallet'),
//                   onTap: () {
//                     // Navigate to My Wallet page
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.book),
//                   title: Text('My Bookings'),
//                   onTap: () {
//                     // Navigate to My Bookings page
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.settings),
//                   title: Text('Settings'),
//                   onTap: () {
//                     // Navigate to Settings page
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.help),
//                   title: Text('Help Center'),
//                   onTap: () {
//                     // Navigate to Help Center page
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.privacy_tip),
//                   title: Text('Privacy Policy'),
//                   onTap: () {
//                     // Navigate to Privacy Policy page
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.logout),
//                   title: Text('Log out'),
//                   onTap: () {
//                     // Handle logout
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(
//       home: ProfileScreen(),
//     ));

//popup profile page
import 'package:flutter/material.dart';

class AnimatedStudentProfile extends StatefulWidget {
  const AnimatedStudentProfile({super.key});

  @override
  State<AnimatedStudentProfile> createState() => _AnimatedStudentProfileState();
}

class _AnimatedStudentProfileState extends State<AnimatedStudentProfile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Adjust duration as needed
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller, curve: Curves.easeOutBack), // More bouncy
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Start slightly below
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              // Put Opacity here
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CircleAvatar(
                          radius: 90,
                          // backgroundImage: AssetImage(
                          //   'assets/images/profilepic.jpg',
                          // ),
                          backgroundImage: NetworkImage(
                              'data:image/jpeg;base64,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'),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'Yogita Shaje',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDetailRow('Roll Number', '7'),
                        _buildDetailRow('Date of Birth', '27 dec'),
                        _buildDetailRow('Blood Group', 'B+'),
                        _buildDetailRow('Emergency Contact', '9823378602'),
                        _buildDetailRow('Position in Class', '12th'),
                        _buildDetailRow('Father\'s Name', 'Zahir Abbas'),
                        _buildDetailRow('Mother\'s Name', 'Mobina'),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text(
                            'Ask for Update',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
