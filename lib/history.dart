// import 'package:flutter/material.dart';
// import 'package:hotelbooking/details.dart';
// import 'package:hotelbooking/home.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: MyBookingsScreen(),
//   ));
// }

// class MyBookingsScreen extends StatefulWidget {
//   @override
//   _MyBookingsScreenState createState() => _MyBookingsScreenState();
// }

// class _MyBookingsScreenState extends State<MyBookingsScreen> {
//   final List<Map<String, dynamic>> completedBookings = [
//     {
//       "image":
//           "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
//       "name": "HarborHaven Hideaway",
//       "location": "New York, USA",
//       "rating": 4.8,
//       "discount": "10% OFF",
//       "price": "\$700/night"
//     },
//     {
//       "image":
//           'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
//       "name": "AlohaVista",
//       "location": "New York, USA",
//       "rating": 4.6,
//       "discount": "15% OFF",
//       "price": "\$450/night"
//     },
//     {
//       "image":
//           "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
//       "name": "GoldenValley",
//       "location": "New York, USA",
//       "rating": 4.9,
//       "discount": "5% OFF",
//       "price": "\$150/night"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: 'History',
//         onSearch: (String) {},
//       ),
//       body: ListView.builder(
//         itemCount: completedBookings.length,
//         itemBuilder: (context, index) {
//           final booking = completedBookings[index];
//           return _buildBookingCard(booking);
//         },
//       ),
//     );
//   }

//   Widget _buildBookingCard(Map<String, dynamic> booking) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             // Row: Image + Hotel Info
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Image on Left
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                     booking["image"],
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 // Hotel Details on Right
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Row: Discount + Rating at the Top
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 6, vertical: 2),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               booking["discount"],
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Row(
//                             children: [
//                               Icon(Icons.star, color: Colors.orange, size: 16),
//                               SizedBox(width: 3),
//                               Text(
//                                 booking["rating"].toString(),
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       // Hotel Name and Location
//                       Text(
//                         booking["name"],
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         booking["location"],
//                         style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         booking["price"],
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             // Buttons Below the Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => HotelDetail(
//                               image: '',
//                             ),
//                           ));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: Text(
//                       "Re-Book",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {},
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: Text("Add Review"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hotelbooking/details.dart';
import 'package:hotelbooking/home.dart';

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
  final List<Map<String, dynamic>> completedBookings = [
    {
      "image":
          "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
      "name": "HarborHaven Hideaway",
      "location": "New York, USA",
      "rating": 4.8,
      "discount": "10% OFF",
      "price": "\$700/night"
    },
    {
      "image":
          'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
      "name": "AlohaVista",
      "location": "New York, USA",
      "rating": 4.6,
      "discount": "15% OFF",
      "price": "\$450/night"
    },
    {
      "image":
          "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
      "name": "GoldenValley",
      "location": "New York, USA",
      "rating": 4.9,
      "discount": "5% OFF",
      "price": "\$150/night"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('History'),
      //   backgroundColor: Colors.blue,
      // ),
      appBar: CustomAppBar(
        title: 'History',
        onSearch: (String) {},
      ),
      body: ListView.builder(
        itemCount: completedBookings.length,
        itemBuilder: (context, index) {
          final booking = completedBookings[index];
          return _buildBookingCard(booking);
        },
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              booking["discount"],
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 10),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              SizedBox(width: 3),
                              Text(
                                booking["rating"].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelDetail(image: ''),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Re-Book",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showReviewDialog(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("Add Review"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
}
