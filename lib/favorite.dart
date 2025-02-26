
// import 'package:flutter/material.dart';
// import 'package:hotelbooking/home.dart';

// class WishlistScreen extends StatefulWidget {
//   const WishlistScreen({Key? key}) : super(key: key);

//   @override
//   State<WishlistScreen> createState() => _WishlistScreenState();
// }

// class _WishlistScreenState extends State<WishlistScreen> {
//   final List<Map<String, dynamic>> items = [
//     {
//       "name": "Golden Valley",
//       "price": "\$150/night",
//       "location": "New York, USA",
//       "rating": 4.9,
//       "discount": "10% Off",
//       "image":
//           'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
//       "isFavorite": false, // Track favorite status
//     },
//     {
//       "name": "Aloha Vista",
//       "price": "\$450/night",
//       "location": "New York, USA",
//       "rating": 4.8,
//       "discount": "10% Off",
//       "image":
//           'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
//       "isFavorite": false,
//     },
//     {
//       "name": "Sea Breeze",
//       "price": "\$300/night",
//       "location": "Los Angeles, USA",
//       "rating": 4.7,
//       "discount": "15% Off",
//       "image":
//           'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
//       "isFavorite": false,
//     },
//     {
//       "name": "Mountain Retreat",
//       "price": "\$250/night",
//       "location": "Denver, USA",
//       "rating": 4.6,
//       "discount": "20% Off",
//       "image":
//           'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
//       "isFavorite": false,
//     },
//   ];

//   void toggleFavorite(int index) {
//     setState(() {
//       items[index]["isFavorite"] = !items[index]["isFavorite"];
//     });
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
//               isFavorite: item["isFavorite"],
//               onFavoriteToggle: () => toggleFavorite(index),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class FavoriteItem extends StatelessWidget {
//   const FavoriteItem({
//     Key? key,
//     required this.imagePath,
//     required this.title,
//     required this.location,
//     required this.price,
//     required this.rating,
//     required this.discount,
//     required this.isFavorite,
//     required this.onFavoriteToggle,
//   }) : super(key: key);

//   final String imagePath;
//   final String title;
//   final String location;
//   final String price;
//   final double rating;
//   final String discount;
//   final bool isFavorite;
//   final VoidCallback onFavoriteToggle;

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
//                 imagePath,
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
//                   // Discount & Favorite Icon in the same row
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
//                           discount,
//                           style: const TextStyle(
//                             fontSize: 10,
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: onFavoriteToggle,
//                         child: Icon(
//                           isFavorite ? Icons.favorite : Icons.favorite_border,
//                           color: isFavorite ? Colors.red : Colors.grey,
//                           size: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   // Title & Rating in the same row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           title,
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
//                             rating.toString(),
//                             style: const TextStyle(
//                                 fontSize: 12, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     location,
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                   Text(
//                     price,
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


import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Map<String, dynamic>> items = [
    {
      "name": "Golden Valley",
      "price": "\$150/night",
      "location": "New York, USA",
      "rating": 4.9,
      "discount": "10% Off",
      "image":
          'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
      "isFavorite": false, // ✅ Added favorite state
    },
    {
      "name": "Aloha Vista",
      "price": "\$450/night",
      "location": "New York, USA",
      "rating": 4.8,
      "discount": "10% Off",
      "image":
          'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
      "isFavorite": false,
    },
  ];

  // Function to toggle favorite status
  void toggleFavorite(int index) {
    setState(() {
      items[index]["isFavorite"] = !items[index]["isFavorite"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Favorite Hotels')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return FavoriteItem(
              imagePath: item["image"],
              title: item["name"],
              location: item["location"],
              price: item["price"],
              rating: item["rating"],
              discount: item["discount"],
              isFavorite: item["isFavorite"],
              onFavoriteToggle: () => toggleFavorite(index), // ✅ Toggle function
            );
          },
        ),
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
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final String location;
  final String price;
  final double rating;
  final String discount;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Discount & Favorite Icon in the same row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                        onTap: onFavoriteToggle, // ✅ Toggles favorite status
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Title & Rating in the same row
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
                            style: const TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: const TextStyle(fontSize: 12),
                  ),
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
