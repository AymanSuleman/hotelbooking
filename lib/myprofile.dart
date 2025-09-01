// import 'package:flutter/material.dart';

// class MyProfile extends StatefulWidget {
//   @override
//   _MyProfileState createState() => _MyProfileState();
// }

// class _MyProfileState extends State<MyProfile> {
//   // Controllers for capturing the input text
//   final TextEditingController _nameController =
//       TextEditingController(text: "Esther Howard");
//   final TextEditingController _phoneController =
//       TextEditingController(text: "603.555.0123");
//   final TextEditingController _emailController =
//       TextEditingController(text: "example@gmail.com");
//   final TextEditingController _dobController =
//       TextEditingController(text: "DD/MM/YY");

//   // Variable to hold the selected gender
//   String _selectedGender = "Select";

//   // Method to handle profile update
//   void _updateProfile() {
//     // You can now access the updated values through the controllers
//     String updatedName = _nameController.text;
//     String updatedPhone = _phoneController.text;
//     String updatedEmail = _emailController.text;
//     String updatedDob = _dobController.text;

//     // Show a dialog or a snackbar to confirm the update
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Profile Updated'),
//         content: Text(
//           'Name: $updatedName\nPhone: $updatedPhone\nEmail: $updatedEmail\nDOB: $updatedDob\nGender: $_selectedGender',
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text('Profile Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'Name',
//                 style: TextStyle(fontSize: 16.0, color: Colors.grey),
//               ),
//               TextField(
//                 controller: _nameController,
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                 decoration: InputDecoration(
//                   hintText: 'Enter your name',
//                   border: InputBorder.none, // No border
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 'Phone Number',
//                 style: TextStyle(fontSize: 16.0, color: Colors.grey),
//               ),
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: _phoneController,
//                       style: TextStyle(
//                           fontSize: 20.0, fontWeight: FontWeight.bold),
//                       decoration: InputDecoration(
//                         hintText: 'Enter your phone number',
//                         border: InputBorder.none, // No border
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Handle change phone number if needed
//                     },
//                     child: Text(
//                       'Change',
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 'Email',
//                 style: TextStyle(fontSize: 16.0, color: Colors.grey),
//               ),
//               TextField(
//                 controller: _emailController,
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                 decoration: InputDecoration(
//                   hintText: 'Enter your email',
//                   border: InputBorder.none, // No border
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 'DOB',
//                 style: TextStyle(fontSize: 16.0, color: Colors.grey),
//               ),
//               TextField(
//                 controller: _dobController,
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                 decoration: InputDecoration(
//                   hintText: 'Enter your Date of Birth',
//                   border: InputBorder.none, // No border
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 'Gender',
//                 style: TextStyle(fontSize: 16.0, color: Colors.grey),
//               ),
//               // Container with custom decoration for Dropdown
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: DropdownButton<String>(
//                   value: _selectedGender,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedGender = newValue!;
//                     });
//                   },
//                   isExpanded: true, // Makes the dropdown take full width
//                   underline: SizedBox(), // Hides the default underline
//                   items: <String>['Select', 'Male', 'Female', 'Other']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//               ),
//               SizedBox(height: 40.0),
//               Center(
//                 child: ElevatedButton(
//                   onPressed:
//                       _updateProfile, // Call the update method when pressed
//                   child: Text(
//                     'Update Profile',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//----------------------------------------

// import 'package:flutter/material.dart';

// class MyProfile extends StatefulWidget {
//   @override
//   _MyProfileState createState() => _MyProfileState();
// }

// class _MyProfileState extends State<MyProfile> {
//   bool isEditing = false;
//   TextEditingController nameController =
//       TextEditingController(text: "Antony William");
//   TextEditingController emailController =
//       TextEditingController(text: "AntonyWilliam12@gmail.com");
//   TextEditingController phoneController =
//       TextEditingController(text: "08212452533");
//   TextEditingController idController =
//       TextEditingController(text: "12364648811");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Personal Info")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage("assets/profile.jpg"),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: () {
//                         // Handle profile picture update
//                       },
//                       child: CircleAvatar(
//                         radius: 15,
//                         backgroundColor: Colors.blue,
//                         child: Icon(Icons.edit, size: 15, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             buildTextField("Full Name", nameController),
//             buildTextField("Email", emailController),
//             buildTextField("Phone Number", phoneController),
//             buildTextField("Government ID", idController),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() => isEditing = !isEditing);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//               ),
//               child: Text(
//                 isEditing ? "Save" : "Edit",
//                 style: TextStyle(fontSize: 16 , color: Colors.white),
//               ),
//               // Navigator.push(context, route)
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextFormField(
//         controller: controller,
//         enabled: isEditing,
//         decoration: InputDecoration(
//           labelText: label,
//                 border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),

//           // border: BorderRadius.all(BorderRadius.circular(20)),
//           filled: true,
//           fillColor: Colors.grey[200],
//         ),
//       ),
//     );
//   }
// }

//----------------------------------
import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isEditing = false;
  bool isLoading = true; // To show loading indicator
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idController = TextEditingController();

  // Example API URL
  final String apiUrl =
      "http://172.26.0.1:5000/api/auth/users"; // Replace with your actual API URL

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when the page loads
  }

  // Method to fetch user data from API
  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        var data = jsonDecode(response.body);

        setState(() {
          // Set the fetched data to the text controllers (assuming the response is a list of users)
          var user = data[
              0]; // Assuming the response is an array and we want the first user
          nameController.text = user['name'];
          emailController.text = user['email'];
          phoneController.text =
              user['phone'] ?? '9876586707'; // Handle optional fields
          idController.text = user['_id'];
          isLoading = false; // Data is loaded
        });
      } else {
        // If the server returns an error, show a message
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Info")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? Center(
                child:
                    CircularProgressIndicator()) // Show loading indicator while data is being fetched
            : Column(
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
                              child: Icon(Icons.edit,
                                  size: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  buildTextField("Full Name", nameController),
                  buildTextField("Email", emailController),
                  buildTextField("Phone Number", phoneController),
                  buildTextField("Government ID", idController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => isEditing = !isEditing);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text(
                      isEditing ? "Save" : "Edit",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        enabled: isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
