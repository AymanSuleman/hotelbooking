import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      MyBookingsScreen(
        userId: widget.userId,
        roomId: '',
      ),
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
  Timer? _timer;

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
        Uri.parse('http://192.168.0.32:5000/api/rooms/category/$category');
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
    _timer?.cancel();
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
              featuredCardData != null
                  ? FeaturedCard(
                      // title: featuredCardData!['title'],
                      // subtitle: featuredCardData!['subtitle'],
                      imageUrl: featuredCardData!['imageUrl'],
                    )
                  : Center(child: CircularProgressIndicator()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Other Stays",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  // Text("See all",
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w600,
                  //         color: Colors.deepPurple))
                ],
              ),
              SizedBox(height: 12),
              featuredListings.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: featuredListings.length,
                      itemBuilder: (context, index) {
                        var listing = featuredListings[index];
                        return OtherStayCard(
                          listing: listing,
                          userId: widget.userId,
                          image: listing['image'],
                          title: listing['title'],
                          rating: listing['rating'],
                          roomId: listing['roomId'],
                        ); // 🔥 New Modern Card
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
  final String imageUrl;

  FeaturedCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Text + Button
          Positioned(
            bottom: 28,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Discover the most popular stays",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Explore Now ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
  final Function(bool)? onFavoriteChanged; // ✅ Callback for updating parent UI

  const PopularCard({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
    required this.roomId,
    required this.userId,
    this.onFavoriteChanged,
  });

  @override
  _PopularCardState createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  bool isFavorite = false;

  final String baseUrl = 'http://192.168.0.32:5000/api/wishlist';
  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus(); // ✅ check karega pehle se wishlist me hai ya nahi
  }

  Future<void> _checkFavoriteStatus() async {
    final url = Uri.parse("$baseUrl/${widget.userId}");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> wishlist = json.decode(response.body);
        setState(() {
          isFavorite =
              wishlist.any((item) => item['roomId']['_id'] == widget.roomId);
        });
      }
    } catch (e) {
      print("Error checking wishlist: $e");
    }
  }

  Future<void> _toggleWishlist() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      try {
        final response = await http.post(
          Uri.parse(baseUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "userId": widget.userId,
            "roomId": widget.roomId,
          }),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: "✅ Added to wishlist",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          widget.onFavoriteChanged?.call(true); // ✅ Notify parent
        } else {
          setState(() => isFavorite = false);
          final error = jsonDecode(response.body);
          Fluttertoast.showToast(
            msg: "❌ Error: ${error['error'] ?? 'Failed'}",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        setState(() => isFavorite = false);
        Fluttertoast.showToast(
          msg: "❌ Network error: $e",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } else {
      try {
        final response = await http.delete(
          Uri.parse(baseUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "userId": widget.userId,
            "roomId": widget.roomId,
          }),
        );

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: "Removed from wishlist",
            backgroundColor: Colors.orange,
            textColor: Colors.white,
          );
          widget.onFavoriteChanged?.call(false); // ✅ Notify parent
        } else {
          Fluttertoast.showToast(
            msg: "❌ Failed to remove",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          setState(() => isFavorite = true); // Revert change
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "❌ Network error: $e",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        setState(() => isFavorite = true); // Revert change
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HotelDetail(
                      image: widget.image,
                      userId: widget.userId,
                      roomId: widget.roomId,
                    )));
      },
      child: Container(
        width: 190,
        margin: const EdgeInsets.only(right: 14, bottom: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 6),
            )
          ],
          image: DecorationImage(
            image: NetworkImage(widget.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.65), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            // Hotel Info
            Positioned(
              bottom: 14,
              left: 14,
              right: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        "${widget.rating}",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Favorite Button
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: _toggleWishlist,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black54,
                    size: 22,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OtherStayCard extends StatefulWidget {
  final Map<String, dynamic> listing;
  final String image;
  final String title;
  final double rating;
  final String roomId;
  final String userId;
  final Function(bool)? onFavoriteChanged;

  const OtherStayCard({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
    required this.roomId,
    required this.userId,
    this.onFavoriteChanged,
    required this.listing,
  });

  @override
  _OtherStayCardState createState() => _OtherStayCardState();
}

class _OtherStayCardState extends State<OtherStayCard> {
  bool isFavorite = false;
  final String baseUrl = 'http://192.168.0.32:5000/api/wishlist';

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final url = Uri.parse("$baseUrl/${widget.userId}");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> wishlist = json.decode(response.body);
        setState(() {
          isFavorite = wishlist
              .any((item) => item['roomId']['_id'] == widget.listing["roomId"]);
        });
      }
    } catch (e) {
      print("Error checking wishlist: $e");
    }
  }

  Future<void> _toggleWishlist() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      try {
        final response = await http.post(
          Uri.parse(baseUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "userId": widget.userId,
            "roomId": widget.listing["roomId"],
          }),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "✅ Added to wishlist", backgroundColor: Colors.green);
          widget.onFavoriteChanged?.call(true);
        } else {
          setState(() => isFavorite = false);
          Fluttertoast.showToast(
              msg: "❌ Failed to add", backgroundColor: Colors.red);
        }
      } catch (e) {
        setState(() => isFavorite = false);
        Fluttertoast.showToast(
            msg: "❌ Network error: $e", backgroundColor: Colors.red);
      }
    } else {
      try {
        final response = await http.delete(
          Uri.parse(baseUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "userId": widget.userId,
            "roomId": widget.listing["roomId"],
          }),
        );

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Removed from wishlist", backgroundColor: Colors.orange);
          widget.onFavoriteChanged?.call(false);
        } else {
          Fluttertoast.showToast(
              msg: "❌ Failed to remove", backgroundColor: Colors.red);
          setState(() => isFavorite = true);
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: "❌ Network error: $e", backgroundColor: Colors.red);
        setState(() => isFavorite = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ✅ Navigate to Room Details Page with full data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetail(
              image: widget.image,
              userId: widget.userId,
              roomId: widget.roomId,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
              child: Image.network(widget.listing["imageUrl"],
                  height: 130, width: 120, fit: BoxFit.cover),
            ),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Wishlist Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(widget.listing["title"],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                        ),
                        GestureDetector(
                          onTap: _toggleWishlist,
                          child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.redAccent,
                              size: 20),
                        ),
                      ],
                    ),

                    SizedBox(height: 6),

                    // Location
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 16, color: Colors.blueAccent),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(widget.listing["location"],
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey.shade600),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),

                    SizedBox(height: 6),

                    // Amenities
                    Row(
                      children: [
                        Icon(Icons.wifi, size: 16, color: Colors.green),
                        SizedBox(width: 4),
                        Icon(Icons.pool, size: 16, color: Colors.teal),
                        SizedBox(width: 4),
                        Icon(Icons.local_parking,
                            size: 16, color: Colors.orange),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Price + Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.listing["price"].toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple)),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            SizedBox(width: 4),
                            Text((widget.listing["rating"] ?? 4.5).toString(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
