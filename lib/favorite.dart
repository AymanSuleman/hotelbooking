import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WishlistScreen(),
    );
  }
}

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('Favorite'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search..',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Men'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return WishlistCard(
                  imageUrl: 'https://www.example.com/images/${index + 1}.jpg',
                  title: _wishlistItems[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final List<String> _wishlistItems = [
    'Limited Edition',
    'Outerwear',
    'Pants',
    'Shorts Sporty',
    'Shorts Casual',
    'Casual Tees',
  ];
}

class WishlistCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  WishlistCard({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(imageUrl),
        title: Text(title),
      ),
    );
  }
}
