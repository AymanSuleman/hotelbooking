import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hotelbooking/bookingprocess.dart';
import 'package:hotelbooking/details.dart';
import 'package:hotelbooking/favorite.dart';
import 'package:hotelbooking/history.dart';
import 'package:hotelbooking/profile.dart';
// import 'package:roombooking/detail.dar
// import 'package:hotelbooking/details.dart';
// import 'package:hotelbooking/favorite.dart';
// import 'package:hotelbooking/history.dart';
// import 'package:hotelbooking/profile.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

// import 'package:flutter/material.dart';

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
                  if (widget.onSearch != null) {
                    widget.onSearch!(""); // Reset search
                  }
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
              onChanged: widget.onSearch, // Call search function
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
                if (widget.onSearch != null) {
                  widget.onSearch!(""); // Reset search
                }
              }
            });
          },
        ),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
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

  final List<Widget> screens = [
    HomePage(),
    WishlistScreen(),
    MyBookingsScreen(),
    // HistoryScreen(),
    ProfileScreen(),
    // AnimatedStudentProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,
        color: _selectedIndex == 0 ||
                _selectedIndex == 1 ||
                _selectedIndex == 2 ||
                _selectedIndex == 3
            ? Colors.blue // background for selected items
            : Colors.white, // background for non-selected items
        buttonBackgroundColor: _selectedIndex == 0 ||
                _selectedIndex == 1 ||
                _selectedIndex == 2 ||
                _selectedIndex == 3
            ? Colors.blue // background for selected button
            : Colors.white, // background for non-selected button
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        index: _selectedIndex,
        onTap: _onItemTapped,
        items: <Widget>[
          Icon(Icons.home,
              size: 30,
              color: _selectedIndex == 0 ? Colors.white : Colors.white),
          Icon(Icons.favorite,
              size: 30,
              color: _selectedIndex == 1 ? Colors.white : Colors.white),
          Icon(Icons.history,
              size: 30,
              color: _selectedIndex == 2 ? Colors.white : Colors.white),
          Icon(Icons.person,
              size: 30,
              color: _selectedIndex == 3 ? Colors.white : Colors.white),
        ],
      ),
    );
  }
}

// ✅ Sample Pages
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> popularPlaces = [
    {
      'image':
          'https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg',
      'title': 'The Reefs',
      'rating': 4.9
    },
    {
      'image':
          'https://t3.ftcdn.net/jpg/03/21/78/98/240_F_321789819_Jyv66AM5PoY0j9tZzjkB1c807zQQXtZh.jpg',
      'title': 'Devils Cove',
      'rating': 4.7
    },
    {
      'image':
          'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
      'title': 'Devils Cove',
      'rating': 4.7
    },
    {
      'image':
          'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
      'title': 'Devils Cove',
      'rating': 4.7
    },
  ];

  final List<Map<String, dynamic>> otherStays = [
    {
      "name": "GoldenValley",
      "price": "\$150/night",
      "location": "New York, USA",
      "rating": 4.9,
      "discount": "10% Off",
      "image":
          'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
    },
    {
      "name": "AlohaVista",
      "price": "\$450/night",
      "location": "New York, USA",
      "rating": 4.8,
      "discount": "10% Off",
      "image":
          'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
    },
    {
      "name": "AlohaVista",
      "price": "\$450/night",
      "location": "New York, USA",
      "rating": 4.8,
      "discount": "10% Off",
      "image":
          'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
    },
    {
      "name": "AlohaVista",
      "price": "\$450/night",
      "location": "New York, USA",
      "rating": 4.8,
      "discount": "10% Off",
      "image":
          'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
    },
  ];
  final List<Map<String, dynamic>> featuredListings = [
    {
      "title": "Japanese-Style Hotel",
      "location": "Manado, Sulawesi Utara",
      "price": "\$10,000/night",
      "oldPrice": "\$15,000",
      "size": "2,000 Sqft",
      "imageUrl":
          'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
    },
    {
      "title": "Japanese-Style Hotel",
      "location": "Manado, Sulawesi Utara",
      "price": "\$10,000/night",
      "oldPrice": "\$15,000",
      "size": "2,000 Sqft",
      "imageUrl":
          'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
    },
    {
      "title": "Japanese-Style Hotel",
      "location": "Manado, Sulawesi Utara",
      "price": "\$10,000/night",
      "oldPrice": "\$15,000",
      "size": "2,000 Sqft",
      "imageUrl":
          'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Bali indonesia'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeaturedCard(),
              SizedBox(height: 20),
              Text('What else is popular',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularPlaces.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: PopularPlaceCard(
                        image: popularPlaces[index]['image'],
                        title: popularPlaces[index]['title'],
                        rating: popularPlaces[index]['rating'],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text('Other Stays',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              //new
              ListView.builder(
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
                              top: Radius.circular(15),
                              bottom: Radius.circular(15)),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.7), // Shadow color
                                  spreadRadius: 6, // Spread of the shadow
                                  blurRadius: 8, // Blur effect for the shadow
                                  offset: Offset(4,
                                      8), // Shadow position (vertical offset)
                                ),
                              ],
                            ),
                            child: Image.network(
                              listing["imageUrl"],
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row to align title on the left and price on the right
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
                                      overflow: TextOverflow
                                          .ellipsis, // Prevents text overflow
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        listing["price"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),

                              // Location Row
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(listing["location"],
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                              SizedBox(height: 4),

                              // Size Row
                              Row(
                                children: [
                                  Icon(Icons.square_foot,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(listing["size"],
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
// );
                      // ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(
              'https://t3.ftcdn.net/jpg/04/16/48/08/240_F_416480811_HmtgLEq1GLmqy0WpKuAfuaYFn7u08IyF.jpg'),
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
                  'Discover the most popular places',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Spacer()
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    // Add navigation or action
                  },
                  child: Text(
                    'Explore Now',
                    style: TextStyle(color: Colors.white),
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

// lets try

// Populer place card
class PopularPlaceCard extends StatelessWidget {
  final String image;
  final String title;
  final double rating;

  PopularPlaceCard({
    required this.image,
    required this.title,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelDetail(
                image: image,
              ),
            ));
      },
      splashColor: Colors.blue.withOpacity(0.5), // blue ripple effect
      borderRadius: BorderRadius.circular(15), // Matches the card shape
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
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
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Hero(
                    tag: title, // Unique tag for smooth animation
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      SizedBox(width: 5),
                      Text('$rating Stars',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.all(8), // Padding for inner spacing
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Background color
                    shape: BoxShape.circle, // Makes it round
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.blue, // Icon color
                    // size: 10,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
