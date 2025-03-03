import 'package:flutter/material.dart';
import 'package:hotelbooking/details.dart';
import 'package:hotelbooking/home.dart';
import 'package:hotelbooking/reviewSummery.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyBookingsScreen(),
  ));
}

class MyBookingsScreen extends StatefulWidget {
  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  String selectedFilter = "Active";

  final List<Map<String, dynamic>> bookings = [
    {
      "image":
          "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
      "name": "HarborHaven Hideaway",
      "location": "New York, USA",
      "rating": 4.8,
      "discount": "10% OFF",
      "price": "\$700/night",
      "status": "Active",
    },
    {
      "image":
          'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
      "name": "AlohaVista",
      "location": "New York, USA",
      "rating": 4.6,
      "discount": "15% OFF",
      "price": "\$450/night",
      "status": "Completed",
    },
    {
      "image":
          "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
      "name": "GoldenValley",
      "location": "New York, USA",
      "rating": 4.9,
      "discount": "5% OFF",
      "price": "\$150/night",
      "status": "Canceled",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'History',
        onSearch: (String) {},
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterButton(
                    label: "Active",
                    isSelected: selectedFilter == "Active",
                    onTap: () => setState(() => selectedFilter = "Active")),
                FilterButton(
                    label: "Completed",
                    isSelected: selectedFilter == "Completed",
                    onTap: () => setState(() => selectedFilter = "Completed")),
                FilterButton(
                    label: "Canceled",
                    isSelected: selectedFilter == "Canceled",
                    onTap: () => setState(() => selectedFilter = "Canceled")),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: bookings
                  .where((booking) => booking["status"] == selectedFilter)
                  .map((booking) {
                return BookingCard(
                  booking: booking,
                  onCancel: () {
                    setState(() {
                      booking["status"] = "Canceled";
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final VoidCallback? onCancel;

  BookingCard({required this.booking, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    booking["image"],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking["name"],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        booking["location"],
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        booking["price"],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (booking["status"] == "Active")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: onCancel,
                      child:
                          Text("Cancle", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewSummaryScreen(showContinueButton: false,),
                            ));
                      },
                      child: Text("View Booking",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            if (booking["status"] == "Completed")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelDetail(image: ''),
                            ));
                      },
                      child: Text(
                        "Re-Book",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        _showReviewDialog(context);
                      },
                      child: Text(
                        "Add Review",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            if (booking["status"] == "Canceled")
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelDetail(image: ''),
                      ));
                },
                child: Text(
                  "Re-Book",
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  FilterButton(
      {required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}

void _showReviewDialog(BuildContext context) {
  TextEditingController reviewController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add Review"),
        content: SingleChildScrollView(
          child: Column(
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
                  String userReview = reviewController.text;
                  if (userReview.isNotEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Review submitted!")));
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
    },
  );
}
