import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hotelbooking/home.dart';

class WishlistScreen extends StatefulWidget {
  final String userId;

  const WishlistScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<dynamic> wishlist = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWishlist();
  }

  Future<void> _fetchWishlist() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.32:5000/api/wishlist/${widget.userId}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          wishlist = data.where((item) => item['roomId'] != null).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _removeItem(int index) async {
    final item = wishlist[index];
    final roomId = item['roomId']?['_id'];

    if (roomId == null) return;

    final url = Uri.parse('http://192.168.0.32:5000/api/wishlist');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'userId': widget.userId, 'roomId': roomId});

    try {
      final response = await http.delete(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        setState(() {
          wishlist.removeAt(index);
        });
      } else {
        print('Failed to delete item: ${response.body}');
      }
    } catch (e) {
      print('Error while deleting item: $e');
    }
  }

  void _showDeleteBottomSheet(BuildContext context, int index) {
    final item = wishlist[index];
    final room = item['roomId'];

    if (room == null) return;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Remove from bookmark?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: room['images'] is List && room['images'].isNotEmpty
                        ? Image.network(
                            room['images'][0],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported, size: 80),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(room['name'] ?? 'Unknown Name',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(room['location'] ?? 'Unknown Location'),
                        Text(room['price']?.toString() ?? 'Price Unavailable',
                            style: const TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        _removeItem(index);
                        Navigator.pop(context);
                      },
                      child: const Text('Yes, remove',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Favorite',
        onSearch: (query) {},
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishlist.isEmpty
              ? const Center(
                  child: Text("No items in wishlist.",
                      style: TextStyle(color: Colors.red)))
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                    itemCount: wishlist.length,
                    itemBuilder: (context, index) {
                      final item = wishlist[index];
                      final room = item['roomId'];
                      if (room == null) return const SizedBox();

                      return FavoriteItem(
                        imagePath: (room['images'] is List &&
                                room['images'].isNotEmpty)
                            ? room['images'][0]
                            : '',
                        title: room['name'] ?? 'Unknown',
                        location: room['location'] ?? 'Unknown',
                        price: room['price']?.toString() ?? 'Price Unavailable',
                        rating: (room['rating'] ?? 4.5).toDouble(),
                        discount: '10% Off',
                        onRemove: () => _showDeleteBottomSheet(context, index),
                      );
                    },
                  ),
                ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.discount,
    required this.onRemove,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final String location;
  final String price;
  final double rating;
  final String discount;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: imagePath.isNotEmpty
                  ? Image.network(
                      imagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image_not_supported, size: 80),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          discount,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onRemove,
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14,
                          ),
                          Text(
                            rating.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(location, style: const TextStyle(fontSize: 12)),
                  Text('\$${price}/night',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
