// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'Bali - Indonesia',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications, color: Colors.black),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FeaturedCard(),
//             SizedBox(height: 20),
//             Text(
//               'What else is popular',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.8,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 children: [
//                   PopularPlaceCard(
//                     image: 'assets/reefs.jpg',
//                     title: 'The Reefs',
//                     rating: 4.9,
//                   ),
//                   PopularPlaceCard(
//                     image: 'assets/devils_cove.jpg',
//                     title: "Devils Cove",
//                     rating: 4.7,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FeaturedCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 180,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: DecorationImage(
//           image: AssetImage('assets/bali.jpg'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               gradient: LinearGradient(
//                 colors: [Colors.black.withOpacity(0.6), Colors.transparent],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Discover the most popular places in Bali',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     CircleAvatar(backgroundImage: AssetImage('assets/user1.jpg')),
//                     SizedBox(width: 5),
//                     CircleAvatar(backgroundImage: AssetImage('assets/user2.jpg')),
//                     SizedBox(width: 5),
//                     CircleAvatar(backgroundImage: AssetImage('assets/user3.jpg')),
//                   ],
//                 ),
//                 Spacer(),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueAccent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: Text('Explore Now'),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PopularPlaceCard extends StatelessWidget {
//   final String image;
//   final String title;
//   final double rating;

//   PopularPlaceCard({required this.image, required this.title, required this.rating});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: DecorationImage(
//           image: AssetImage(image),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.black.withOpacity(0.3),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Spacer(),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.yellow, size: 16),
//                     SizedBox(width: 5),
//                     Text(
//                       '$rating Stars',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> popularPlaces = [
    {'image': 'assets/reefs.jpg', 'title': 'The Reefs', 'rating': 4.9},
    {'image': 'assets/devils_cove.jpg', 'title': 'Devils Cove', 'rating': 4.7},
  ];

  final List<Map<String, dynamic>> otherStays = [
    {'image': 'assets/stay1.jpg', 'title': 'Beachside Retreat', 'description': 'A relaxing beachside stay with amazing views.'},
    {'image': 'assets/stay2.jpg', 'title': 'Mountain Escape', 'description': 'Enjoy the serenity of the mountains.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Bali - Indonesia',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeaturedCard(),
              SizedBox(height: 20),
              Text(
                'What else is popular',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularPlaces.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              Text(
                'Other Stays',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: otherStays.length,
                itemBuilder: (context, index) {
                  return OtherStayCard(
                    image: otherStays[index]['image'],
                    title: otherStays[index]['title'],
                    description: otherStays[index]['description'],
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
          image: AssetImage('assets/bali.jpg'),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover the most popular places in Bali',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Explore Now'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopularPlaceCard extends StatelessWidget {
  final String image;
  final String title;
  final double rating;

  PopularPlaceCard({required this.image, required this.title, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(image),
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
                Spacer(),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    SizedBox(width: 5),
                    Text(
                      '$rating Stars',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OtherStayCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  OtherStayCard({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: ListTile(
          leading: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(description),
        ),
      ),
    );
  }
}
