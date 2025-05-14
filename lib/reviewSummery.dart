import 'package:flutter/material.dart';
import 'package:hotelbooking/payment.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReviewSummaryScreen(
        showContinueButton: true), // Default with Continue button
  ));
}

class ReviewSummaryScreen extends StatelessWidget {
  final bool showContinueButton;

  ReviewSummaryScreen({required this.showContinueButton});

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
        title: Text("Review Summary", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("20% Off",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12)),
                          ),
                          Spacer(),
                          Icon(Icons.star, color: Colors.orange, size: 18),
                          Text(" 4.5",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text("HarborHaven Hideaway",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text("New York, USA",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text("\$650 /night",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            buildInfoRow("Booking Date", "August 24, 2023 | 10:00 AM"),
            buildInfoRow("Check In", "October 04, 2023"),
            buildInfoRow("Check Out", "November 03, 2023"),
            buildInfoRow("Guest", "05 Person"),
            Divider(),
            buildInfoRow("Amount", "\$650.00"),
            buildInfoRow("Tax & Fees", "\$50.00"),
            Divider(),
            buildInfoRow("Total", "\$700.00", isBold: true),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Paypal"),
              trailing: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Change", style: TextStyle(color: Colors.blue)),
              ),
            ),
            Spacer(),
            if (showContinueButton) // Show "Continue" button only when needed
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
                    // );
                  },
                  child: Text("Continue",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
