// // import 'package:flutter/material.dart';
// // import 'package:carousel_slider/carousel_slider.dart';

// // class HomePage extends StatefulWidget {
// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   int _selectedIndex = 0;

// //   final List<String> offerImages = [
// //     "https://picsum.photos/id/1018/800/300",
// //     "https://picsum.photos/id/1015/800/300",
// //     "https://picsum.photos/id/1016/800/300",
// //   ];

// //   final List<Map<String, String>> hotels = [
// //     {
// //       "image": "https://picsum.photos/id/1011/400/300",
// //       "title": "Taj Palace, Delhi"
// //     },
// //     {
// //       "image": "https://picsum.photos/id/1012/400/300",
// //       "title": "The Leela, Goa"
// //     },
// //     {
// //       "image": "https://picsum.photos/id/1013/400/300",
// //       "title": "Oberoi Udaivilas, Udaipur"
// //     },
// //     {
// //       "image": "https://picsum.photos/id/1014/400/300",
// //       "title": "ITC Grand Chola, Chennai"
// //     },
// //   ];

// //   final List<Widget> _pages = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _pages.addAll([
// //       _buildHomeContent(), // Home screen content
// //       Center(child: Text("Bookings Page")),
// //       Center(child: Text("Wishlist Page")),
// //       Center(child: Text("Profile Page")),
// //     ]);
// //   }

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }

// //   // 🔍 Separate Hotel Search Screen
// //   void _openSearchScreen() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => HotelSearchScreen()),
// //     );
// //   }

// //   Widget _buildHomeContent() {
// //     return SingleChildScrollView(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // 🔍 Search Box (clickable)
// //           GestureDetector(
// //             onTap: _openSearchScreen,
// //             child: Container(
// //               margin: EdgeInsets.all(16),
// //               padding: EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Icon(Icons.search, color: Colors.grey),
// //                   SizedBox(width: 8),
// //                   Text("Search hotels, cities...",
// //                       style: TextStyle(color: Colors.grey[600])),
// //                   Spacer(),
// //                   Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
// //                 ],
// //               ),
// //             ),
// //           ),

// //           // 🎉 Offers Carousel
// //           CarouselSlider(
// //             options: CarouselOptions(
// //               height: 180,
// //               autoPlay: true,
// //               enlargeCenterPage: true,
// //             ),
// //             items: offerImages.map((img) {
// //               return ClipRRect(
// //                 borderRadius: BorderRadius.circular(12),
// //                 child: Image.network(img, fit: BoxFit.cover, width: 1000),
// //               );
// //             }).toList(),
// //           ),

// //           SizedBox(height: 20),

// //           // 🌍 Popular Hotels
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //             child: Text("Popular Hotels",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //           ),
// //           SizedBox(
// //             height: 220,
// //             child: ListView.builder(
// //               scrollDirection: Axis.horizontal,
// //               itemCount: hotels.length,
// //               itemBuilder: (context, index) {
// //                 final hotel = hotels[index];
// //                 return Container(
// //                   width: 160,
// //                   margin: EdgeInsets.all(10),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       ClipRRect(
// //                         borderRadius: BorderRadius.circular(12),
// //                         child: Image.network(
// //                           hotel["image"]!,
// //                           height: 120,
// //                           fit: BoxFit.cover,
// //                           width: double.infinity,
// //                         ),
// //                       ),
// //                       SizedBox(height: 8),
// //                       Text(hotel["title"]!,
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.bold, fontSize: 14)),
// //                       SizedBox(height: 4),
// //                       Text("Starting from ₹4,999",
// //                           style: TextStyle(color: Colors.grey, fontSize: 12)),
// //                     ],
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),

// //           SizedBox(height: 20),

// //           // 🌟 Recommended Hotels
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //             child: Text("Recommended for You",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //           ),
// //           SizedBox(
// //             height: 220,
// //             child: ListView.builder(
// //               scrollDirection: Axis.horizontal,
// //               itemCount: hotels.length,
// //               itemBuilder: (context, index) {
// //                 final hotel = hotels[index];
// //                 return Container(
// //                   width: 160,
// //                   margin: EdgeInsets.all(10),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       ClipRRect(
// //                         borderRadius: BorderRadius.circular(12),
// //                         child: Image.network(
// //                           hotel["image"]!,
// //                           height: 120,
// //                           fit: BoxFit.cover,
// //                           width: double.infinity,
// //                         ),
// //                       ),
// //                       SizedBox(height: 8),
// //                       Text(hotel["title"]!,
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.bold, fontSize: 14)),
// //                       Row(
// //                         children: [
// //                           Icon(Icons.star, color: Colors.orange, size: 16),
// //                           Text("4.${index + 2}",
// //                               style: TextStyle(fontSize: 12)),
// //                         ],
// //                       )
// //                     ],
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[100],
// //       appBar: AppBar(
// //         title: Text("Hotel Booking"),
// //         backgroundColor: Colors.blueAccent,
// //         actions: [
// //           IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //             child: CircleAvatar(
// //               backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
// //             ),
// //           )
// //         ],
// //       ),
// //       body: _pages[_selectedIndex],
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: Colors.blueAccent,
// //         unselectedItemColor: Colors.grey,
// //         onTap: _onItemTapped,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
// //           BottomNavigationBarItem(
// //               icon: Icon(Icons.calendar_today), label: "Bookings"),
// //           BottomNavigationBarItem(
// //               icon: Icon(Icons.favorite), label: "Wishlist"),
// //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // 🔍 Hotel Search Screen
// // class HotelSearchScreen extends StatelessWidget {
// //   final TextEditingController cityController = TextEditingController();
// //   final TextEditingController checkInController = TextEditingController();
// //   final TextEditingController checkOutController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //           title: Text("Search Hotels"), backgroundColor: Colors.blueAccent),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: cityController,
// //               decoration: InputDecoration(
// //                 labelText: "City or Hotel Name",
// //                 prefixIcon: Icon(Icons.location_city),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             SizedBox(height: 12),
// //             TextField(
// //               controller: checkInController,
// //               decoration: InputDecoration(
// //                 labelText: "Check-in Date",
// //                 prefixIcon: Icon(Icons.calendar_today),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             SizedBox(height: 12),
// //             TextField(
// //               controller: checkOutController,
// //               decoration: InputDecoration(
// //                 labelText: "Check-out Date",
// //                 prefixIcon: Icon(Icons.calendar_today),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.blueAccent,
// //                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14)),
// //               onPressed: () {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(
// //                       content: Text(
// //                           "Searching Hotels in ${cityController.text}...")),
// //                 );
// //               },
// //               child: Text("Search Hotels", style: TextStyle(fontSize: 16)),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // -------------------------------------
// import 'package:flutter/material.dart';

// class HomeScreen12 extends StatefulWidget {
//   final String userId;

//   HomeScreen12({required this.userId});

//   @override
//   _HomeScreen12State createState() => _HomeScreen12State();
// }

// class _HomeScreen12State extends State<HomeScreen12> {
//   // 🔹 Your Hotels Data
//   final List<Map<String, String>> hotels = [
//     {
//       "image": "https://picsum.photos/id/1011/400/300",
//       "title": "Taj Palace, Delhi"
//     },
//     {
//       "image": "https://picsum.photos/id/1012/400/300",
//       "title": "The Leela, Goa"
//     },
//     {
//       "image": "https://picsum.photos/id/1013/400/300",
//       "title": "Oberoi Udaivilas, Udaipur"
//     },
//     {
//       "image": "https://picsum.photos/id/1014/400/300",
//       "title": "ITC Grand Chola, Chennai"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 🔹 Search Section
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(24),
//                   bottomRight: Radius.circular(24),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Find your stay",
//                       style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white)),
//                   SizedBox(height: 16),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Search hotels, cities...",
//                         prefixIcon: Icon(Icons.search, color: Colors.blue),
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.symmetric(vertical: 14),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),

//             // 🔹 Categories
//             Container(
//               height: 100,
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   categoryItem(Icons.hotel, "Hotels"),
//                   categoryItem(Icons.villa, "Villas"),
//                   categoryItem(Icons.pool, "Resorts"),
//                   categoryItem(Icons.apartment, "Apartments"),
//                   categoryItem(Icons.bed, "Hostels"),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),

//             // 🔹 Featured Hotels (Horizontal List)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text("Featured Hotels",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             ),
//             SizedBox(height: 10),
//             Container(
//               height: 220,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: hotels.length,
//                 itemBuilder: (context, index) {
//                   final hotel = hotels[index];
//                   return featuredHotelCard(
//                     hotel["title"]!,
//                     "City Center",
//                     "₹${(2000 + index * 500).toString()}/night",
//                     hotel["image"]!,
//                   );
//                 },
//               ),
//             ),

//             SizedBox(height: 20),

//             // 🔹 Recommended Hotels (Vertical List)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text("Recommended For You",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: hotels.length,
//               itemBuilder: (context, index) {
//                 final hotel = hotels[index];
//                 return recommendedHotelCard(
//                   hotel["title"]!,
//                   "Popular Location",
//                   "₹${(2500 + index * 600).toString()}/night",
//                   hotel["image"]!,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔹 Category Item
//   Widget categoryItem(IconData icon, String title) {
//     return Container(
//       width: 80,
//       margin: EdgeInsets.only(right: 12),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 28,
//             backgroundColor: Colors.blue.shade100,
//             child: Icon(icon, color: Colors.blue, size: 28),
//           ),
//           SizedBox(height: 8),
//           Text(title,
//               style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }

//   // 🔹 Featured Hotel Card
//   Widget featuredHotelCard(
//       String name, String location, String price, String imageUrl) {
//     return Container(
//       width: 160,
//       margin: EdgeInsets.only(left: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//             child: Image.network(imageUrl,
//                 height: 120, width: 160, fit: BoxFit.cover),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Text(location, style: TextStyle(color: Colors.grey)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(price,
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 Recommended Hotel Card
//   Widget recommendedHotelCard(
//       String name, String location, String price, String imageUrl) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
//             child: Image.network(imageUrl,
//                 height: 100, width: 100, fit: BoxFit.cover),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
//                   SizedBox(height: 4),
//                   Text(location, style: TextStyle(color: Colors.grey)),
//                   SizedBox(height: 6),
//                   Text(price,
//                       style: TextStyle(
//                           color: Colors.blue, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:hotelbooking/details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // keep track of favorite states
  final Map<String, bool> _favorites = {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.05; // 5% screen width

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Current location",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Wallace, Australia",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3)),
                      ],
                    ),
                    child: const Icon(Icons.notifications_none,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🔹 Tabs
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTab(true, Icons.hotel, "Hotel"),
                    _buildTab(false, Icons.home, "Homestay"),
                    _buildTab(false, Icons.apartment, "Apart"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Near Location Section
              _sectionHeader("Near Location"),
              SizedBox(
                height: size.height * 0.32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _hotelCard(
                        context,
                        size,
                        "The Aston Vill Hotel",
                        "Alice Springs NT 0870, Australia",
                        "https://picsum.photos/300/200",
                        200.7,
                        5.0),
                    _hotelCard(
                        context,
                        size,
                        "Golden Peak Hotel",
                        "Northern Territory, Australia",
                        "https://picsum.photos/301/200",
                        175.9,
                        4.8),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Popular Hotel Section
              _sectionHeader("Popular Hotel"),
              _popularHotelCard(
                  context,
                  size,
                  "Asteria Hotel",
                  "Wilora NT 0872, Australia",
                  "https://picsum.photos/302/200",
                  165.3,
                  5.0),
            ],
          ),
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: _bottomNav(),
    );
  }

  // --- WIDGETS ---

  Widget _buildTab(bool active, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF4D5DFA) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: active ? Colors.white : Colors.grey),
          const SizedBox(width: 6),
          Text(text,
              style: TextStyle(
                  color: active ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SeeAllScreen()),
            );
          },
          child: const Text("See all",
              style: TextStyle(
                  color: Color(0xFF7B61FF), fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget _hotelCard(BuildContext context, Size size, String name,
      String location, String imgUrl, double price, double rating) {
    final isFav = _favorites[name] ?? false;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelDetailPage(
              // name: name,
              // location: location,
              // imgUrl: imgUrl,
              // price: price,
              // rating: rating,
            ),
          ),
        );
      },
      child: Container(
        width: size.width * 0.65,
        margin: const EdgeInsets.only(right: 16, top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Image + Heart icon
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(imgUrl, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _favorites[name] = !isFav;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 🔹 Hotel Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(location,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$$price /night",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4D5DFA))),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: Color(0xFFFFC107)),
                          const SizedBox(width: 4),
                          Text(rating.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _popularHotelCard(BuildContext context, Size size, String name,
      String location, String imgUrl, double price, double rating) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelDetailPage(
              // name: name,
              // location: location,
              // imgUrl: imgUrl,
              // price: price,
              // rating: rating,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imgUrl,
                  width: size.width * 0.25,
                  height: size.width * 0.2,
                  fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(location,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$$price /night",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4D5DFA))),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: Color(0xFFFFC107)),
                          const SizedBox(width: 4),
                          Text(rating.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: const Color(0xFF4D5DFA),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: "Schedule"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border), label: "Saved"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Profile"),
      ],
    );
  }
}

// 🔹 Dummy See All Page
class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Hotels")),
      body: const Center(child: Text("All hotel listings go here...")),
    );
  }
}

