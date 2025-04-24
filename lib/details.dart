// // import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:hotelbooking/userInfo.dart';

// class HotelDetail extends StatefulWidget {
//   final String image;

//   HotelDetail({
//     required this.image, required String userId, required roomId,
//   });

//   @override
//   _HotelDetailState createState() => _HotelDetailState();
// }

// class _HotelDetailState extends State<HotelDetail>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentImageIndex = 0;
//   bool _isExpanded = false; // State for "Read More"
//   DateTime checkInDateTime = DateTime(2025, 10, 4, 14, 0);
//   DateTime checkOutDateTime = DateTime(2025, 11, 3, 11, 0);

//   final List<String> imageList = [
//     "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
//     "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
//     "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
//     "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('detail Page'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite_border, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       "Total Price",
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 4),
//                     const Text(
//                       "\$650 /night",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _showBookingBottomSheet(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     "Book Now",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Image Slider
//             Stack(
//               children: [
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 250,
//                     autoPlay: true,
//                     viewportFraction: 1,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         _currentImageIndex = index;
//                       });
//                     },
//                   ),
//                   items: imageList.map((image) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Image.network(
//                           image,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 Positioned(
//                   bottom: 15,
//                   left: MediaQuery.of(context).size.width / 2 - 30,
//                   child: Row(
//                     children: List.generate(imageList.length, (index) {
//                       return Container(
//                         margin: EdgeInsets.symmetric(horizontal: 3),
//                         width: _currentImageIndex == index ? 10 : 8,
//                         height: _currentImageIndex == index ? 10 : 8,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: _currentImageIndex == index
//                               ? Colors.blue
//                               : Colors.grey,
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 15),

//             // Hotel Info
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "HarborHaven Hideaway",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Icon(Icons.location_on, color: Colors.blue),
//                       SizedBox(width: 5),
//                       Text(
//                         "1012 Ocean Avenue, New York, USA",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.star, color: Colors.orange, size: 20),
//                           Text(" 4.5 (365 reviews)"),
//                         ],
//                       ),
//                       Container(
//                         // height: min(300, 500),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           '10%off',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 15),
//                 ],
//               ),
//             ),

//             // Tab Bar
//             TabBar(
//               controller: _tabController,
//               indicatorColor: Colors.blue,
//               labelColor: Colors.black,
//               unselectedLabelColor: Colors.grey,
//               tabs: [
//                 Tab(text: "About"),
//                 Tab(text: "Gallery"),
//                 Tab(text: "Review"),
//               ],
//             ),

//             // Tab Bar View
//             Container(
//               height: MediaQuery.of(context).size.height * 0.4, // Adjust height
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildAboutSection(),
//                   _buildGallerySection(),
//                   _buildReviewSection(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // About Section
//   Widget _buildAboutSection() {
//     String aboutText =
//         "This luxurious hotel offers stunning ocean views, comfortable rooms, and top-notch services. The rooms are spacious and beautifully decorated, featuring modern amenities such as flat-screen TVs, high-speed internet, and premium bedding for a restful night’s sleep. Perfect for a relaxing stay, this hotel is a haven for those seeking tranquility and luxury.";

//     bool isTextLong = aboutText.length > 100;

//     return Padding(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             _isExpanded ? aboutText : aboutText.substring(0, 200) + "...",
//             style: TextStyle(fontSize: 16, color: Colors.black87),
//           ),
//           SizedBox(height: 10),
//           if (isTextLong)
//             InkWell(
//               onTap: () {
//                 setState(() {
//                   _isExpanded = !_isExpanded;
//                 });
//               },
//               child: Text(
//                 _isExpanded ? "Read Less" : "Read More",
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//               ),
//             ),
//           SizedBox(height: 15),
//         ],
//       ),
//     );
//   }

//   // Gallery Section
//   Widget _buildGallerySection() {
//     final List<String> imageUrls = [
//       "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
//       "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
//     ];

//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: GridView.builder(
//         shrinkWrap: true,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 1,
//         ),
//         itemCount: imageUrls.length,
//         itemBuilder: (context, index) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               imageUrls[index],
//               fit: BoxFit.cover,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Review Section
//   Widget _buildReviewSection() {
//     return Padding(
//       padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
//       child: Column(
//         children: [
//           _buildReviewItem("John Doe", "Amazing place! Loved my stay."),
//           _buildReviewItem("Alice Smith", "Beautiful views and great service."),
//         ],
//       ),
//     );
//   }

//   Widget _buildReviewItem(String name, String review) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 10),
//       child: ListTile(
//         leading: CircleAvatar(child: Icon(Icons.person)),
//         title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(review),
//       ),
//     );
//   }

//   void _showBookingBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade100,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         "10% Off",
//                         style: TextStyle(
//                             color: Colors.blue, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Spacer(),
//                     RatingBarIndicator(
//                       rating: 4.5,
//                       itemBuilder: (context, index) =>
//                           Icon(Icons.star, color: Colors.amber),
//                       itemCount: 5,
//                       itemSize: 20.0,
//                     ),
//                     Text(" (365 reviews)"),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Text("HarborHaven Hideaway",
//                     style:
//                         TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                 Text("1012 Ocean Avenue, New York, USA",
//                     style: TextStyle(color: Colors.grey)),
//                 SizedBox(height: 20),
//                 _buildDateTimeSelector("Check In", checkInDateTime, true),
//                 SizedBox(height: 10),
//                 _buildDateTimeSelector("Check Out", checkOutDateTime, false),
//                 SizedBox(height: 30),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Enter note to owner",
//                     border: OutlineInputBorder(),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                   ),
//                 ),
//                 // Spacer(),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     onPressed: () {
//                       showGuestSelectionSheet(context);
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                       child: Text("Continue",
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _selectDateTime(BuildContext context, bool isCheckIn) async {
//     DateTime initialDate = isCheckIn ? checkInDateTime : checkOutDateTime;

//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate == null) return;

//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.fromDateTime(initialDate),
//     );

//     if (pickedTime == null) return;

//     setState(() {
//       if (isCheckIn) {
//         checkInDateTime = DateTime(
//           pickedDate.year,
//           pickedDate.month,
//           pickedDate.day,
//           pickedTime.hour,
//           pickedTime.minute,
//         );
//       } else {
//         checkOutDateTime = DateTime(
//           pickedDate.year,
//           pickedDate.month,
//           pickedDate.day,
//           pickedTime.hour,
//           pickedTime.minute,
//         );
//       }
//     });
//   }

//   Widget _buildDateTimeSelector(
//       String title, DateTime dateTime, bool isCheckIn) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         SizedBox(height: 5),
//         GestureDetector(
//           onTap: () => _selectDateTime(context, isCheckIn),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "${_getWeekday(dateTime.weekday)}, ${dateTime.day} ${_getMonth(dateTime.month)} ${dateTime.year}",
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "${_formatTime(dateTime.hour, dateTime.minute)}",
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String _getMonth(int month) {
//     return [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec"
//     ][month - 1];
//   }

//   String _getWeekday(int day) {
//     return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][day - 1];
//   }

//   String _formatTime(int hour, int minute) {
//     String amPm = hour >= 12 ? "PM" : "AM";
//     int formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
//     return "$formattedHour:${minute.toString().padLeft(2, '0')} $amPm";
//   }
// }

// void showGuestSelectionSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
//     ),
//     builder: (context) => GuestSelectionBottomSheet(),
//   );
// }

// // guest selection

// class GuestSelectionBottomSheet extends StatefulWidget {
//   @override
//   _GuestSelectionBottomSheetState createState() =>
//       _GuestSelectionBottomSheetState();
// }

// class _GuestSelectionBottomSheetState extends State<GuestSelectionBottomSheet> {
//   int adults = 1;
//   int children = 0;
//   int infants = 0;

//   void updateGuestCount(String type, bool increment) {
//     setState(() {
//       switch (type) {
//         case 'Adults':
//           if (increment)
//             adults++;
//           else if (adults > 1) adults--;
//           break;
//         case 'Children':
//           if (increment)
//             children++;
//           else if (children > 0) children--;
//           break;
//         case 'Infants':
//           if (increment)
//             infants++;
//           else if (infants > 0) infants--;
//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text("Select Guest",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           SizedBox(height: 10),
//           buildGuestRow("Adults", "Ages 18 or Above", adults),
//           buildGuestRow("Children", "Ages 2-17", children),
//           buildGuestRow("Infants", "Under Age 2", infants),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserInfo(),
//                   ));
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//             ),
//             child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: Center(
//                     child: Text("Continue",
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)))),
//           ),
//           SizedBox(height: 10),
//         ],
//       ),
//     );
//   }

//   Widget buildGuestRow(String title, String subtitle, int count) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               Text(subtitle,
//                   style: TextStyle(fontSize: 14, color: Colors.grey)),
//             ],
//           ),
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () => updateGuestCount(title, false),
//                 icon: Icon(
//                   Icons.remove_circle,
//                   color: Colors.blue,
//                 ),
//               ),
//               Text(count.toString(),
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               IconButton(
//                 onPressed: () => updateGuestCount(title, true),
//                 icon: Icon(
//                   Icons.add_circle,
//                   color: Colors.blue,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hotelbooking/userInfo.dart';

class Room {
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final String location;
  final double rating;

  Room({
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.location,
    required this.rating,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      location: json['location'] ?? 'Unknown',
      rating: (json['rating'] ?? 4.0).toDouble(),
    );
  }
}

class HotelDetail extends StatefulWidget {
  final String roomId;
  final String image;

  HotelDetail(
      {required this.roomId, required this.image, required String userId});

  @override
  _HotelDetailState createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentImageIndex = 0;
  bool _isExpanded = false;
  Room? room;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchRoomDetails();
  }

  Future<void> fetchRoomDetails() async {
    final url =
        Uri.parse('http://192.168.0.39:5000/api/rooms/${widget.roomId}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          room = Room.fromJson(json.decode(response.body));
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load room');
      }
    } catch (e) {
      print("Error fetching room: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Loading...")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (room == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Room Details")),
        body: Center(child: Text("Room not found")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Room Details'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index %
                            room!.images
                                .length; // Ensure index stays within bounds
                      });
                    },
                  ),
                  items: room!.images.map((image) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(room!.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(room!.location,
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          SizedBox(width: 4),
                          Text("${room!.rating.toStringAsFixed(1)} / 5.0"),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("10% Off",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "About"),
                Tab(text: "Gallery"),
                Tab(text: "Review"),
              ],
            ),
            Container(
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAboutSection(room!.description),
                  _buildGallerySection(room!.images),
                  _buildReviewSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Price", style: TextStyle(color: Colors.grey)),
                Text("\$${room!.price}/night",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () => showGuestSelectionSheet(context),
              child: Text("Book Now",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildAboutSection(String aboutText) {
  //   bool isTextLong = aboutText.length > 100;
  //   return Padding(
  //     padding: EdgeInsets.all(20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           _isExpanded ? aboutText : aboutText.substring(0, 200) + "...",
  //           style: TextStyle(fontSize: 16),
  //         ),
  //         SizedBox(height: 10),
  //         if (isTextLong)
  //           InkWell(
  //             onTap: () => setState(() => _isExpanded = !_isExpanded),
  //             child: Text(_isExpanded ? "Read Less" : "Read More",
  //                 style: TextStyle(
  //                     color: Colors.blue, fontWeight: FontWeight.bold)),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildAboutSection(String aboutText) {
    bool isTextLong = aboutText.length > 100;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isExpanded
                ? aboutText
                : aboutText.length > 200
                    ? aboutText.substring(0, 200) + "..."
                    : aboutText, // Check length before substring
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          if (isTextLong)
            InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Text(_isExpanded ? "Read Less" : "Read More",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildGallerySection(List<String> imageUrls) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: imageUrls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(imageUrls[index], fit: BoxFit.cover),
        );
      },
    );
  }

  Widget _buildReviewSection() {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        _buildReviewItem("John Doe", "Amazing experience!"),
        _buildReviewItem("Jane Smith", "Would stay again!"),
      ],
    );
  }

  Widget _buildReviewItem(String name, String comment) {
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.person)),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(comment),
    );
  }
}

void showGuestSelectionSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => GuestSelectionBottomSheet(),
  );
}

class GuestSelectionBottomSheet extends StatefulWidget {
  @override
  _GuestSelectionBottomSheetState createState() =>
      _GuestSelectionBottomSheetState();
}

class _GuestSelectionBottomSheetState extends State<GuestSelectionBottomSheet> {
  int adults = 1, children = 0, infants = 0;

  void updateGuest(String type, bool increment) {
    setState(() {
      if (type == 'Adults') {
        if (increment)
          adults++;
        else if (adults > 1) adults--;
      } else if (type == 'Children') {
        if (increment)
          children++;
        else if (children > 0) children--;
      } else {
        if (increment)
          infants++;
        else if (infants > 0) infants--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Select Guests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          buildCounter("Adults", adults),
          buildCounter("Children", children),
          buildCounter("Infants", infants),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UserInfo()),
              );
            },
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(
                  child: Text("Continue",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          )
        ],
      ),
    );
  }

  Widget buildCounter(String label, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(label), Text("Age details")]),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.blue),
              onPressed: () => updateGuest(label, false),
            ),
            Text('$count'),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.blue),
              onPressed: () => updateGuest(label, true),
            )
          ],
        )
      ],
    );
  }
}
