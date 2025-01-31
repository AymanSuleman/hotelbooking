
//new one

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotelbooking/payment.dart';

//

class HotelDetailPage extends StatefulWidget {
  final String image;

  HotelDetailPage({
    required this.image,
  });
  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentImageIndex = 0;
  bool _isExpanded = false; // State for "Read More"

  final List<String> imageList = [
    "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
    "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
    "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
    "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
            // Image Slider
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  items: imageList.map((image) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: 15,
                  left: MediaQuery.of(context).size.width / 2 - 30,
                  child: Row(
                    children: List.generate(imageList.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        width: _currentImageIndex == index ? 10 : 8,
                        height: _currentImageIndex == index ? 10 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageIndex == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            // Hotel Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HarborHaven Hideaway",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        "1012 Ocean Avenue, New York, USA",
                        style: TextStyle(color: Colors.grey),
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
                          Text(" 4.5 (365 reviews)"),
                        ],
                      ),
                      Text(
                        "\$650 / night",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),

            // Tab Bar
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

            // Tab Bar View
            Container(
              height: MediaQuery.of(context).size.height * 0.4, // Adjust height
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAboutSection(),
                  _buildGallerySection(),
                  _buildReviewSection(),
                ],
              ),
            ),

            // Booking Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Book Hotel",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDateSelector("Check In", "Today\n4 Oct"),
                          _buildDateSelector("Check Out", "Sun\n7 Nov"),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentSuccessPage()));
                          },
                          child:
                              Text("Book Now", style: TextStyle(fontSize: 18,color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // About Section
  Widget _buildAboutSection() {
    // Text content for the About section
    String aboutText =
        "This luxurious hotel offers stunning ocean views, comfortable rooms, and top-notch services. The rooms are spacious and beautifully decorated, featuring modern amenities such as flat-screen TVs, high-speed internet, and premium bedding for a restful night’s sleep.  Perfect for a relaxing stay, this hotel is a haven for those seeking tranquility and luxury.";

    // Determine if the text is too long
    bool isTextLong =
        aboutText.length > 100; // You can adjust the length threshold

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // If expanded, show full text, otherwise show truncated version
            _isExpanded ? aboutText : aboutText.substring(0, 200) + "...",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 10),
          // Show "Read More" only if the text is long enough
          if (isTextLong)
            InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? "Read Less" : "Read More",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.people, color: Colors.blue),
              SizedBox(width: 5),
              Text(
                "Max 4 People",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.bed, color: Colors.blue),
              SizedBox(width: 5),
              Text(
                "2 King-sized Beds",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.room_service, color: Colors.blue),
              SizedBox(width: 5),
              Text(
                "Room Service Available",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Gallery Section
  // Gallery Section
  Widget _buildGallerySection() {
    // List of image URLs
    final List<String> imageUrls = [
      "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
      "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
      "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
      "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
    ];

    return Padding(
      padding: EdgeInsets.all(10), // Padding for gallery section
      child: GridView.builder(
        shrinkWrap:
            true, // Ensures the GridView doesn't take more space than needed
        // physics:AlwaysScrollableScrollPhysics()
        // NeverScrollableScrollPhysics(), // Disables scrolling for GridView inside SingleChildScrollView
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns in grid
          crossAxisSpacing: 10, // Space between columns
          mainAxisSpacing: 10, // Space between rows
          childAspectRatio: 1, // Aspect ratio for images
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrls[index], // Image URL from the list
              fit: BoxFit.cover, // Ensures the image covers the available space
            ),
          );
        },
      ),
    );
  }

  // Review Section
  Widget _buildReviewSection() {
    return Padding(
      padding: EdgeInsets.only(
          top: 10, bottom: 10, left: 20, right: 20), // Adjusted bottom space
      child: Column(
        children: [
          _buildReviewItem("John Doe", "Amazing place! Loved my stay."),
          _buildReviewItem("Alice Smith", "Beautiful views and great service."),
          _buildReviewItem("Alice Smith", "Beautiful views and great service."),
          _buildReviewItem("Alice Smith", "Beautiful views and great service."),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, String review) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(review),
      ),
    );
  }

  Widget _buildDateSelector(String title, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 5),
        Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
