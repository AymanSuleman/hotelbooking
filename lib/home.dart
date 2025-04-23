import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotelbooking/favorite.dart';
import 'package:hotelbooking/history.dart';
import 'package:hotelbooking/profile.dart';
import 'package:http/http.dart' as http;
import 'package:hotelbooking/details.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// CustomAppBar and HomeScreen remain unchanged...
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function(String)? onSearch;

  CustomAppBar({required this.title, this.onSearch});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: _isSearching,
      leading: _isSearching
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                  widget.onSearch?.call("");
                });
              },
            )
          : null,
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
              onChanged: widget.onSearch,
            )
          : Text(widget.title,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.clear : Icons.search,
              color: Colors.black),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchController.clear();
                widget.onSearch?.call("");
              }
            });
          },
        ),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String userId;

  HomeScreen({required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen1(userId: widget.userId),
      WishlistScreen(userId: widget.userId),
      MyBookingsScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        buttonBackgroundColor: Colors.blue,
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        index: _selectedIndex,
        onTap: _onItemTapped,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.history, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}

class HomeScreen1 extends StatefulWidget {
  final String userId;

  HomeScreen1({required this.userId});

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  Map<String, dynamic>? featuredCardData;
  List<Map<String, dynamic>> popularPlaces = [];
  List<Map<String, dynamic>> featuredListings = [];
  late List<String> images;
  int currentImageIndex = 0;
  bool isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    fetchRoomsByCategory('Featured Cards', (data) {
      if (data.isNotEmpty) {
        setState(() {
          featuredCardData = data[0];
          images = List<String>.from(featuredCardData!['images']);
          currentImageIndex = 0;
          isLoading = false;
        });

        _timer = Timer.periodic(Duration(seconds: 3), (timer) {
          if (mounted && images.isNotEmpty) {
            setState(() {
              currentImageIndex = (currentImageIndex + 1) % images.length;
            });
          }
        });
      }
    });

    fetchRoomsByCategory('Popular Stays', (data) {
      setState(() {
        popularPlaces = data;
      });
    });

    fetchRoomsByCategory('Other Stays', (data) {
      setState(() {
        featuredListings = data;
      });
    });
  }

  Future<void> fetchRoomsByCategory(
      String category, Function(List<Map<String, dynamic>>) onSuccess) async {
    final url =
        Uri.parse('http://192.168.0.6:5000/api/rooms/category/$category');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        onSuccess(data
            .map<Map<String, dynamic>>((room) => {
                  'title': room['name'],
                  'subtitle': room['description'],
                  'rating': 4.5,
                  'price': "\$${room['price']}/night",
                  'image': room['images'][0],
                  'roomId': room['_id'],
                  'location': 'Unknown',
                  'imageUrl': room['images'][0],
                  'size': '2,000 Sqft'
                })
            .toList());
      }
    } catch (e) {
      print('Error fetching rooms for $category: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Bali Indonesia'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : FeaturedCard(
                      title: featuredCardData!['title'],
                      subtitle: featuredCardData!['subtitle'],
                      images: images,
                      currentImageIndex: currentImageIndex,
                    ),
              SizedBox(height: 20),
              Text('What else is popular',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              popularPlaces.isNotEmpty
                  ? Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularPlaces.length,
                        itemBuilder: (context, index) {
                          final place = popularPlaces[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: PopularCard(
                              image: place['image'],
                              title: place['title'],
                              rating: place['rating'],
                              roomId: place['roomId'],
                              userId: widget.userId,
                            ),
                          );
                        },
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
              SizedBox(height: 20),
              Text('Other Stays',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              featuredListings.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: featuredListings.length,
                      itemBuilder: (context, index) {
                        var listing = featuredListings[index];
                        return Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: Image.network(
                                  listing["imageUrl"],
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            listing["title"],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          listing["price"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,
                                            size: 16, color: Colors.grey),
                                        SizedBox(width: 4),
                                        Text(listing["location"],
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.square_foot,
                                            size: 16, color: Colors.grey),
                                        SizedBox(width: 4),
                                        Text(listing["size"],
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> images;
  final int currentImageIndex;

  FeaturedCard({
    required this.title,
    required this.subtitle,
    required this.images,
    required this.currentImageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(images[currentImageIndex]),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {},
                  child: Text(subtitle, style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopularCard extends StatefulWidget {
  final String image;
  final String title;
  final double rating;
  final String roomId;
  final String userId;

  const PopularCard({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
    required this.roomId,
    required this.userId,
  });

  @override
  _PopularCardState createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  bool isFavorite = false;

  final String baseUrl = 'http://192.168.0.39:5000/api/wishlist';

  Future<void> _toggleWishlist() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      try {
        // 🔍 Debug the IDs before sending the API request
        print("Sending userId: ${widget.userId}");
        print("Sending roomId: ${widget.roomId}");
        print(
            "Room ID valid format? ${RegExp(r'^[a-f\d]{24}$').hasMatch(widget.roomId)}");

        final response = await http.post(
          Uri.parse(baseUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "userId": widget.userId,
            "roomId": widget.roomId,
          }),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Added to wishlist")),
          );
        } else {
          setState(() => isFavorite = false);
          final error = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ Error: ${error['error']}")),
          );
        }
      } catch (e) {
        setState(() => isFavorite = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Network error: $e")),
        );
      }
    } else {
      // Optional: Implement deletion if required
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HotelDetail(
                    image: widget.image,
                    userId: widget.userId,
                    roomId: widget.roomId,
                  )),
        );
      },
      splashColor: Colors.blue.withOpacity(0.5),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(widget.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                      const SizedBox(width: 5),
                      Text('${widget.rating} Stars',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: _toggleWishlist,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
