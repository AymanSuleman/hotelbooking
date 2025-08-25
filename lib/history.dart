//----------------------------------------------------
import 'package:flutter/material.dart';
import 'package:hotelbooking/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotelbooking/reviewSummery.dart';

class MyBookingsScreen extends StatefulWidget {
  final String userId;

  final String roomId;
  const MyBookingsScreen({Key? key, required this.userId, required this.roomId})
      : super(key: key);

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  List<dynamic> allBookings = [];

  @override
  void initState() {
    super.initState();
    fetchBookings(widget.userId);
  }

  Future<void> fetchBookings(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.32:5000/api/bookings/user/$userId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          allBookings = json.decode(response.body);
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  List<dynamic> get filteredBookings =>
      allBookings.where((b) => b["status"] == "Confirmed").toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'History',
        onSearch: (query) {},
      ),
      body: filteredBookings.isEmpty
          ? Center(child: Text("No confirmed bookings."))
          : ListView.builder(
              itemCount: filteredBookings.length,
              itemBuilder: (context, index) {
                return BookingCard(
                  booking: filteredBookings[index],
                  userId: widget.userId,
                  roomId: widget.roomId,
                );
              },
            ),
    );
  }
}

//----------------------------------
class BookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final String userId;
  final String roomId;
  BookingCard(
      {required this.booking, required this.userId, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final room = booking["room"] ?? {};
    final String name = room["name"] ?? "Unnamed Room";
    final String location = room["location"] ?? "Unknown Location";
    final double price = (room["price"] ?? 0).toDouble();
    final List images = room["images"] ?? [];
    final String imageUrl =
        images.isNotEmpty ? images[0] : 'https://via.placeholder.com/100';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 160, // Adjusted height for a compact look
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),

          // Room Name
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // Room Location
          Text(
            location,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),

          // Room Price
          SizedBox(height: 4),
          Text(
            "\$${price.toStringAsFixed(0)} / night",
            style: TextStyle(
                fontSize: 15,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600),
          ),

          // Add Review Button
          SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showReviewDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              icon: Icon(Icons.reviews, color: Colors.white),
              label: Text("Add Review", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    final reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Review"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reviewController,
              decoration: InputDecoration(
                hintText: "Write your review...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String comment = reviewController.text;

                if (comment.isNotEmpty) {
                  // Call the submitReview function with dynamic userId, roomId, rating, and comment
                  submitReview(
                    userId: userId, // Use the passed userId dynamically
                    roomId: booking["room"]["id"], // Room ID
                    comment: comment,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Review submitted successfully!")),
                  );
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please write a comment.")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// Update submitReview to check for valid ObjectId format
Future<void> submitReview({
  required String userId,
  required String roomId,
  required String comment,
}) async {
  final url = Uri.parse('http://192.168.0.32:5000/api/reviews');
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "userId": userId,
      "roomId": roomId,
      "comment": comment,
    }),
  );

  if (response.statusCode == 201) {
    print("Review submitted successfully");
  } else {
    print("Failed to submit review: ${response.body}");
  }
}
