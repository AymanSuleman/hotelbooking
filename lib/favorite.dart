
// import 'package:flutter/material.dart';
// import 'package:hotelbooking/home.dart';

// class WishlistScreen extends StatefulWidget {
//   const WishlistScreen({Key? key}) : super(key: key);

//   @override
//   State<WishlistScreen> createState() => _WishlistScreenState();
// }

// class _WishlistScreenState extends State<WishlistScreen> {
//   List<Map<String, dynamic>> items = [
//     {
//       "name": "GoldenValley",
//       "price": "\$150/night",
//       "location": "New York, USA",
//       "rating": 4.9,
//       "discount": "10% Off",
//       "image":
//           'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
//     },
//     {
//       "name": "AlohaVista",
//       "price": "\$450/night",
//       "location": "New York, USA",
//       "rating": 4.8,
//       "discount": "10% Off",
//       "image":
//           'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
//     },
//     {
//       "name": "GoldenValley",
//       "price": "\$150/night",
//       "location": "New York, USA",
//       "rating": 4.9,
//       "discount": "10% Off",
//       "image":
//           'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
//     },
//      {
//       "name": "AlohaVista",
//       "price": "\$450/night",
//       "location": "New York, USA",
//       "rating": 4.8,
//       "discount": "10% Off",
//       "image":
//           'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
//     },
//   ];

//   void _removeItem(int index) {
//     setState(() {
//       items.removeAt(index);
//     });
//   }

//   void _showDeleteBottomSheet(BuildContext context, int index) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         final item = items[index];
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Remove from bookmark?',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       item["image"],
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item["name"],
//                           style:
//                               TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Text(item["location"]),
//                         Text(
//                           item["price"],
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8))),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text('Cancel', style: TextStyle(color: Colors.white,),),
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8))),
//                       onPressed: () {
//                         _removeItem(index);
//                         Navigator.pop(context);
//                       },
//                       child: Text('Yes, remove',style: TextStyle(color: Colors.white),),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: 'Favorite',
//         onSearch: (String) {},
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final item = items[index];
//             return FavoriteItem(
//               imagePath: item["image"],
//               title: item["name"],
//               location: item["location"],
//               price: item["price"],
//               rating: item["rating"],
//               discount: item["discount"],
//               onRemove: () => _showDeleteBottomSheet(context, index),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class FavoriteItem extends StatefulWidget {
//   const FavoriteItem({
//     Key? key,
//     required this.imagePath,
//     required this.title,
//     required this.location,
//     required this.price,
//     required this.rating,
//     required this.discount,
//     required this.onRemove,
//   }) : super(key: key);

//   final String imagePath;
//   final String title;
//   final String location;
//   final String price;
//   final double rating;
//   final String discount;
//   final VoidCallback onRemove;

//   @override
//   _FavoriteItemState createState() => _FavoriteItemState();
// }

// class _FavoriteItemState extends State<FavoriteItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Padding(
//         padding: const EdgeInsets.all(6.0),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(6.0),
//               child: Image.network(
//                 widget.imagePath,
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 6, vertical: 2),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           widget.discount,
//                           style: const TextStyle(
//                             fontSize: 10,
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: widget.onRemove,
//                         child: Icon(
//                           Icons.favorite,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           widget.title,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.star,
//                             color: Colors.yellow,
//                             size: 14,
//                           ),
//                           Text(
//                             widget.rating.toString(),
//                             style: const TextStyle(
//                                 fontSize: 12, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     widget.location,
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                   Text(
//                     widget.price,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.bold,
//                     ),
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


//new //
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// CustomAppBar (replace with your own app bar if needed)
import 'package:hotelbooking/home.dart'; // Ensure this file contains CustomAppBar

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
    final response = await http.get(
      Uri.parse('http://192.168.0.50:5000/api/wishlist/$userId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        wishlist = data['wishlist'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error (Snackbar/toast/etc.)
    }
  }

  void _removeItem(int index) {
    setState(() {
      wishlist.removeAt(index);
    });
  }

  void _showDeleteBottomSheet(BuildContext context, int index) {
    final item = wishlist[index]['roomId'];
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
              Text('Remove from bookmark?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(item['location'] ?? 'Unknown'),
                        Text(item['price'].toString(),
                            style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child:
                          Text('Cancel', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _removeItem(index);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: Text('Yes, remove',
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
          ? Center(child: CircularProgressIndicator())
          : wishlist.isEmpty
              ? Center(child: Text("No items in wishlist"))
              : ListView.builder(
                  itemCount: wishlist.length,
                  itemBuilder: (context, index) {
                    final room = wishlist[index]['roomId'];
                    return FavoriteItem(
                      imagePath: room['image'],
                      title: room['name'],
                      location: room['location'] ?? 'Unknown',
                      price: room['price'].toString(),
                      rating: (room['rating'] ?? 4.5).toDouble(),
                      discount: room['discount'] ?? '10% Off',
                      onRemove: () => _showDeleteBottomSheet(context, index),
                    );
                  },
                ),
    );
  }
}

// Favorite Item Widget
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
              child: Image.network(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
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
                        child: Icon(
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(location, style: const TextStyle(fontSize: 12)),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

