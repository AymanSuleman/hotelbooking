// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:hotelbooking/payment.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:hotelbooking/userInfo.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Room {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final List<String> images;
//   final String location;
//   final double rating;

//   Room({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.images,
//     required this.location,
//     required this.rating,
//   });

//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//       id: json['_id'],
//       name: json['name'],
//       description: json['description'] ?? '',
//       price: (json['price'] ?? 0).toDouble(),
//       images: List<String>.from(json['images'] ?? []),
//       location: json['location'] ?? 'Unknown',
//       rating: (json['rating'] ?? 4.0).toDouble(),
//     );
//   }
// }

// class HotelDetail extends StatefulWidget {
//   final String roomId;
//   final String userId;
//   final String image;

//   HotelDetail({
//     required this.roomId,
//     required this.userId,
//     required this.image,
//   });

//   @override
//   _HotelDetailState createState() => _HotelDetailState();
// }

// class _HotelDetailState extends State<HotelDetail>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentImageIndex = 0;
//   bool _isExpanded = false;
//   Room? room;
//   bool isLoading = true;
//   bool isFavorite = false;
//   List<dynamic> reviews = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     fetchRoomDetails();
//     checkFavoriteStatus();
//     fetchAndSetReviews();
//   }

//   Future<void> fetchRoomDetails() async {
//     final url = Uri.parse('http://172.26.0.1:5000/api/rooms/${widget.roomId}');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         setState(() {
//           room = Room.fromJson(json.decode(response.body));
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load room');
//       }
//     } catch (e) {
//       print("Error fetching room: $e");
//       setState(() => isLoading = false);
//     }
//   }

//   Future<void> checkFavoriteStatus() async {
//     final url =
//         Uri.parse("http://172.26.0.1:5000/api/wishlist/${widget.userId}");
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final List<dynamic> wishlist = json.decode(response.body);
//         setState(() {
//           isFavorite =
//               wishlist.any((item) => item['roomId']['_id'] == widget.roomId);
//         });
//       }
//     } catch (e) {
//       print("Error checking wishlist: $e");
//     }
//   }

//   Future<void> toggleFavorite() async {
//     final url = Uri.parse("http://172.26.0.1:5000/api/wishlist");
//     try {
//       final response = isFavorite
//           ? await http.delete(
//               url,
//               headers: {"Content-Type": "application/json"},
//               body: json.encode({
//                 "userId": widget.userId,
//                 "roomId": widget.roomId,
//               }),
//             )
//           : await http.post(
//               url,
//               headers: {"Content-Type": "application/json"},
//               body: json.encode({
//                 "userId": widget.userId,
//                 "roomId": widget.roomId,
//               }),
//             );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         setState(() {
//           isFavorite = !isFavorite;
//         });
//       } else {
//         print("Failed to toggle favorite: ${response.body}");
//       }
//     } catch (e) {
//       print("Error toggling favorite: $e");
//     }
//   }

//   Future<void> fetchAndSetReviews() async {
//     final url =
//         Uri.parse('http://172.26.0.1:5000/api/reviews/${widget.roomId}');
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         reviews = data["reviews"];
//       });
//     } else {
//       print("Error fetching reviews: ${response.body}");
//     }
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(title: Text("Loading...")),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (room == null) {
//       return Scaffold(
//         appBar: AppBar(title: Text("Room Details")),
//         body: Center(child: Text("Room not found")),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Room Details'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: isFavorite ? Colors.blue : Colors.black,
//             ),
//             onPressed: toggleFavorite,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: 250,
//                 autoPlay: true,
//                 viewportFraction: 1,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _currentImageIndex = index % room!.images.length;
//                   });
//                 },
//               ),
//               items: room!.images.map((image) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.network(
//                       image,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(room!.name,
//                       style:
//                           TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Icon(Icons.location_on, color: Colors.blue),
//                       SizedBox(width: 5),
//                       Expanded(
//                         child: Text(room!.location,
//                             style: TextStyle(color: Colors.grey)),
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
//                           SizedBox(width: 4),
//                           Text("${room!.rating.toStringAsFixed(1)} / 5.0"),
//                         ],
//                       ),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade300,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text("10% Off",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
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
//             Container(
//               height: 200,
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildAboutSection(room!.description),
//                   _buildGallerySection(room!.images),
//                   _buildReviewSection(),
//                 ],
//               ),
//             ),
//           ],
//         ),
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
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Total Price", style: TextStyle(color: Colors.grey)),
//                     Text("\$${room!.price}/night",
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12))),
//                   onPressed: () =>
//                       _showBookingBottomSheet(context, room!, widget.userId),
//                   child: Text("Book Now",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAboutSection(String aboutText) {
//     bool isTextLong = aboutText.length > 100;
//     return Padding(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             _isExpanded
//                 ? aboutText
//                 : aboutText.length > 200
//                     ? aboutText.substring(0, 200) + "..."
//                     : aboutText,
//             style: TextStyle(fontSize: 16),
//           ),
//           SizedBox(height: 10),
//           if (isTextLong)
//             InkWell(
//               onTap: () => setState(() => _isExpanded = !_isExpanded),
//               child: Text(_isExpanded ? "Read Less" : "Read More",
//                   style: TextStyle(
//                       color: Colors.blue, fontWeight: FontWeight.bold)),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGallerySection(List<String> imageUrls) {
//     return GridView.builder(
//       shrinkWrap: true,
//       padding: EdgeInsets.all(10),
//       itemCount: imageUrls.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
//       itemBuilder: (context, index) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image.network(imageUrls[index], fit: BoxFit.cover),
//         );
//       },
//     );
//   }

//   Widget _buildReviewSection() {
//     if (reviews.isEmpty) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Text(
//             "No reviews yet.",
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: EdgeInsets.all(20),
//       itemCount: reviews.length,
//       itemBuilder: (context, index) {
//         return _buildReviewItem(reviews[index]);
//       },
//     );
//   }

//   Widget _buildReviewItem(Map<String, dynamic> review) {
//     final String name = review["userId"]?["name"] ?? "Anonymous";
//     final String comment = review["comment"] ?? "";
//     return ListTile(
//       leading: CircleAvatar(child: Icon(Icons.person)),
//       title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
//       subtitle: Text(comment),
//     );
//   }
// }
// //review

// Future<List<dynamic>> fetchReviews(String roomId) async {
//   final url = Uri.parse('http://172.26.0.1:5000/api/reviews/$roomId');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     return data["reviews"];
//   } else {
//     print("Error fetching reviews: ${response.body}");
//     return [];
//   }
// }

// //check in or check out

// void _showBookingBottomSheet(BuildContext context, Room room, String userId) {
//   DateTime checkInDate = DateTime.now();
//   DateTime checkOutDate = DateTime.now().add(Duration(days: 1));

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) {
//       return Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           left: 16,
//           right: 16,
//           top: 20,
//         ),
//         child: StatefulBuilder(
//           builder: (context, setState) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Select Check-in and Check-out Dates",
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 12),
//                 _buildDateTimeSelector(context, "Check In", checkInDate,
//                     () async {
//                   final selected = await _selectDateTime(context, checkInDate);
//                   if (selected != null) {
//                     setState(() => checkInDate = selected);
//                   }
//                 }),
//                 SizedBox(height: 10),
//                 _buildDateTimeSelector(context, "Check Out", checkOutDate,
//                     () async {
//                   final selected = await _selectDateTime(context, checkOutDate);
//                   if (selected != null) {
//                     setState(() => checkOutDate = selected);
//                   }
//                 }),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context); // Close current modal
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(20)),
//                       ),
//                       builder: (context) {
//                         return GuestSelectionBottomSheet(
//                           userId: userId,
//                           roomId: room.id,
//                           checkInDate: checkInDate,
//                           checkOutDate: checkOutDate,
//                           pricePerNight: room.price,
//                         );
//                       },
//                     );
//                   },
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: Center(
//                       child: Text("Continue",
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       );
//     },
//   );
// }

// Widget _buildDateTimeSelector(
//     BuildContext context, String title, DateTime dateTime, VoidCallback onTap) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//       SizedBox(height: 5),
//       GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "${_getWeekday(dateTime.weekday)}, ${dateTime.day} ${_getMonth(dateTime.month)} ${dateTime.year}",
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "${_formatTime(dateTime.hour, dateTime.minute)}",
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Future<DateTime?> _selectDateTime(
//     BuildContext context, DateTime initialDate) async {
//   DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: initialDate,
//     firstDate: DateTime.now(),
//     lastDate: DateTime(2100),
//   );
//   if (pickedDate == null) return null;

//   TimeOfDay? pickedTime = await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay.fromDateTime(initialDate),
//   );
//   if (pickedTime == null) return null;

//   return DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
//       pickedTime.hour, pickedTime.minute);
// }

// String _getMonth(int month) => [
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

// String _getWeekday(int day) =>
//     ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][day - 1];

// String _formatTime(int hour, int minute) {
//   String amPm = hour >= 12 ? "PM" : "AM";
//   int formattedHour = hour % 12 == 0 ? 12 : hour % 12;
//   return "$formattedHour:${minute.toString().padLeft(2, '0')} $amPm";
// }

// //

// // Updated GuestSelectionBottomSheet with booking API integration and dynamic parameters

// class GuestSelectionBottomSheet extends StatefulWidget {
//   final String userId;
//   final String roomId;
//   final DateTime checkInDate;
//   final DateTime checkOutDate;
//   final double pricePerNight;

//   GuestSelectionBottomSheet({
//     required this.userId,
//     required this.roomId,
//     required this.checkInDate,
//     required this.checkOutDate,
//     required this.pricePerNight,
//   });

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

//   Future<void> bookRoom() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userId = prefs.getString('userId'); // ✅ fetch from saved login

//     if (userId == null || userId.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("User not logged in. Please sign in.")),
//       );
//       return;
//     }

//     final url = Uri.parse("http://172.26.0.1:5000/api/bookings");
//     final totalGuests = adults + children + infants;
//     final nights = widget.checkOutDate.difference(widget.checkInDate).inDays;
//     final totalPrice = widget.pricePerNight * nights;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => Center(child: CircularProgressIndicator()),
//     );

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         // If your booking API needs token:
//         'Authorization': 'Bearer ${prefs.getString('token') ?? ''}',
//       },
//       body: jsonEncode({
//         "userId": userId, // ✅ Now it's coming from SharedPreferences
//         "roomId": widget.roomId,
//         "checkInDate": widget.checkInDate.toIso8601String(),
//         "checkOutDate": widget.checkOutDate.toIso8601String(),
//         "guests": totalGuests,
//         "totalPrice": totalPrice
//       }),
//     );

//     Navigator.pop(context);

//     if (response.statusCode == 201) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Booking successful!")),
//       );
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => PaymentSuccessPage(userId: userId),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Booking failed: ${response.body}")),
//       );
//     }
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
//           SizedBox(height: 20),
//           buildGuestRow("Adults", "Ages 18 or Above", adults),
//           buildGuestRow("Children", "Ages 2-17", children),
//           buildGuestRow("Infants", "Under Age 2", infants),
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: bookRoom,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//             ),
//             child: SizedBox(
//               width: double.infinity,
//               height: 40,
//               child: Center(
//                 child: Text("Continue",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
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
//                 icon: Icon(Icons.remove_circle, color: Colors.blue),
//               ),
//               Text(count.toString(),
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               IconButton(
//                 onPressed: () => updateGuestCount(title, true),
//                 icon: Icon(Icons.add_circle, color: Colors.blue),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// void showGuestSelectionSheet({
//   required BuildContext context,
//   required String userId,
//   required String roomId,
//   required DateTime checkInDate,
//   required DateTime checkOutDate,
//   required double pricePerNight,
// }) {
//   showModalBottomSheet(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     builder: (context) => GuestSelectionBottomSheet(
//       userId: userId,
//       roomId: roomId,
//       checkInDate: checkInDate,
//       checkOutDate: checkOutDate,
//       pricePerNight: pricePerNight,
//     ),
//   );
// }


import 'package:flutter/material.dart';

class HotelDetailPage extends StatefulWidget {
  const HotelDetailPage({super.key});

  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Detail",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Image + Favorite
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    "https://picsum.photos/600/300",
                    width: size.width,
                    height: size.height * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: InkWell(
                    onTap: () {
                      setState(() => isFavorite = !isFavorite);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Features Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeature(Icons.wifi, "Free Wifi"),
                _buildFeature(Icons.free_breakfast, "Free Breakfast"),
                _buildFeature(Icons.star, "5.0"),
              ],
            ),
            const SizedBox(height: 20),

            // Title + Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "The Aston Vill Hotel",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "\$200.7 /night",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Location
            Row(
              children: const [
                Icon(Icons.location_on, size: 18, color: Colors.blue),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Alice Springs NT 0870, Australia",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            const Text("Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text(
              "Aston Hotel, Alice Springs NT 0870, Australia is a modern hotel. "
              "Elegant 5 star hotel overlooking the sea. Perfect for a romantic, charming ",
              style: TextStyle(color: Colors.grey),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Read More...",
                style: TextStyle(
                    color: Colors.blue.shade700, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),

            // Preview Images
            const Text("Preview",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPreviewImage("https://picsum.photos/200/300"),
                  _buildPreviewImage("https://picsum.photos/201/300"),
                  _buildPreviewImage("https://picsum.photos/202/300"),
                  _buildPreviewImage("https://picsum.photos/203/300"),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Booking Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF7B61FF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {},
          child: const Text(
            "Booking Now",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildPreviewImage(String url) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          url,
          width: 100,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
