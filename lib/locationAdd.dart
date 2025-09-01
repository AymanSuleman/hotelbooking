import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<String> offerImages = [
    "https://picsum.photos/id/1018/800/300",
    "https://picsum.photos/id/1015/800/300",
    "https://picsum.photos/id/1016/800/300",
  ];

  final List<Map<String, String>> hotels = [
    {
      "image": "https://picsum.photos/id/1011/400/300",
      "title": "Taj Palace, Delhi"
    },
    {
      "image": "https://picsum.photos/id/1012/400/300",
      "title": "The Leela, Goa"
    },
    {
      "image": "https://picsum.photos/id/1013/400/300",
      "title": "Oberoi Udaivilas, Udaipur"
    },
    {
      "image": "https://picsum.photos/id/1014/400/300",
      "title": "ITC Grand Chola, Chennai"
    },
  ];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildHomeContent(), // Home screen content
      Center(child: Text("Bookings Page")),
      Center(child: Text("Wishlist Page")),
      Center(child: Text("Profile Page")),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 🔍 Separate Hotel Search Screen
  void _openSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HotelSearchScreen()),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔍 Search Box (clickable)
          GestureDetector(
            onTap: _openSearchScreen,
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text("Search hotels, cities...",
                      style: TextStyle(color: Colors.grey[600])),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),

          // 🎉 Offers Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: offerImages.map((img) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(img, fit: BoxFit.cover, width: 1000),
              );
            }).toList(),
          ),

          SizedBox(height: 20),

          // 🌍 Popular Hotels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Popular Hotels",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return Container(
                  width: 160,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          hotel["image"]!,
                          height: 120,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(hotel["title"]!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 4),
                      Text("Starting from ₹4,999",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20),

          // 🌟 Recommended Hotels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Recommended for You",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return Container(
                  width: 160,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          hotel["image"]!,
                          height: 120,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(hotel["title"]!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Text("4.${index + 2}",
                              style: TextStyle(fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Hotel Booking"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
            ),
          )
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// 🔍 Hotel Search Screen
class HotelSearchScreen extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController checkInController = TextEditingController();
  final TextEditingController checkOutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Search Hotels"), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: "City or Hotel Name",
                prefixIcon: Icon(Icons.location_city),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: checkInController,
              decoration: InputDecoration(
                labelText: "Check-in Date",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: checkOutController,
              decoration: InputDecoration(
                labelText: "Check-out Date",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          "Searching Hotels in ${cityController.text}...")),
                );
              },
              child: Text("Search Hotels", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
