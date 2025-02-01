import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EnterLocationScreen(),
  ));
}

class EnterLocationScreen extends StatefulWidget {
  @override
  _EnterLocationScreenState createState() => _EnterLocationScreenState();
}

class _EnterLocationScreenState extends State<EnterLocationScreen> {
  TextEditingController _locationController = TextEditingController();
  List<String> searchResults = [
    "Golden Avenue - 8502 Preston Rd, Inglewood",
    "Broadway Street - 901 Sunset Blvd, LA",
    "Downtown Plaza - 123 Main St, NY"
  ]; // Mock search results

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Your Location",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            // Search Field
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: _locationController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _locationController.clear();
                          });
                        },
                      )
                    : null,
                hintText: "Search location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: (text) {
                setState(() {}); // Refresh UI on text change
              },
            ),
            SizedBox(height: 15),
            // Use My Current Location
            ListTile(
              leading: Icon(Icons.my_location, color: Colors.blue),
              title: Text("Use my current location"),
              onTap: () {
                // Handle location fetching logic
              },
            ),
            Divider(),
            SizedBox(height: 10),
            Text(
              "SEARCH RESULT",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blue),
                    title: Text(searchResults[index]),
                    onTap: () {
                      // Handle selection
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
