import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // Controllers for capturing the input text
  final TextEditingController _nameController =
      TextEditingController(text: "Esther Howard");
  final TextEditingController _phoneController =
      TextEditingController(text: "603.555.0123");
  final TextEditingController _emailController =
      TextEditingController(text: "example@gmail.com");
  final TextEditingController _dobController =
      TextEditingController(text: "DD/MM/YY");

  // Variable to hold the selected gender
  String _selectedGender = "Select";

  // Method to handle profile update
  void _updateProfile() {
    // You can now access the updated values through the controllers
    String updatedName = _nameController.text;
    String updatedPhone = _phoneController.text;
    String updatedEmail = _emailController.text;
    String updatedDob = _dobController.text;

    // Show a dialog or a snackbar to confirm the update
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Profile Updated'),
        content: Text(
          'Name: $updatedName\nPhone: $updatedPhone\nEmail: $updatedEmail\nDOB: $updatedDob\nGender: $_selectedGender',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Profile Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Name',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              TextField(
                controller: _nameController,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  border: InputBorder.none, // No border
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Phone Number',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        border: InputBorder.none, // No border
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle change phone number if needed
                    },
                    child: Text(
                      'Change',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Email',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              TextField(
                controller: _emailController,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: InputBorder.none, // No border
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'DOB',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              TextField(
                controller: _dobController,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Enter your Date of Birth',
                  border: InputBorder.none, // No border
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Gender',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              // Container with custom decoration for Dropdown
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  value: _selectedGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  },
                  isExpanded: true, // Makes the dropdown take full width
                  underline: SizedBox(), // Hides the default underline
                  items: <String>['Select', 'Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 40.0),
              Center(
                child: ElevatedButton(
                  onPressed:
                      _updateProfile, // Call the update method when pressed
                  child: Text(
                    'Update Profile',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
