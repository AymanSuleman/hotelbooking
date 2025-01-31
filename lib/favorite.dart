// import 'package:flutter/material.dart';
// import 'package:hotelbooking/home.dart';

// class WishlistScreen extends StatefulWidget {
//   const WishlistScreen({Key? key}) : super(key: key);

//   @override
//   State<WishlistScreen> createState() => _WishlistScreenState();
// }

// class _WishlistScreenState extends State<WishlistScreen> {
//   // Define the items list based on the JSON structure
//   final List<Map<String, dynamic>> items = [
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
//       "name": "HarborHaven Hideaway",
//       "price": "\$700/night",
//       "location": "New York, USA",
//       "rating": 4.8,
//       "discount": "10% Off",
//       "image":
//           'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
//     },
//     {
//       "name": "Emerald Echo Oasis",
//       "price": "Price not available", // Using a placeholder for the price
//       "location": "New York, USA",
//       "rating": 4.8,
//       "discount": "10% Off",
//       "image":
//           'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Bali - Indonesia',
//         onSearch: (String) {},
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return FavoriteItem(
//                     imagePath: item["image"],
//                     title: item["name"],
//                     location: item["location"],
//                     price: item["price"],
//                     rating: item["rating"],
//                     discount: item["discount"],
//                   );
//                 },
//               ),
//             ),
//           ],
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
//   }) : super(key: key);

//   final String imagePath;
//   final String title;
//   final String location;
//   final String price;
//   final double rating;
//   final String discount;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             // Image and icons stack
//             Stack(
//               alignment: Alignment.topRight,
//               children: [
//                 // Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Image.network(
//                     imagePath,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 // Solid Favorite Icon at the top right (no border)
//                 Positioned(
//                   right: 5,
//                   top: 5,
//                   child: Icon(
//                     Icons.favorite, // Solid heart icon (no border)
//                     color: Colors.blue,
//                     size: 24,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Row for title and rating
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         title,
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.star,
//                             color: Colors.yellow,
//                             size: 16,
//                           ),
//                           Text(
//                             rating.toString(),
//                             style: const TextStyle(color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Text(location),
//                   Text(price),
//                   Row(
//                     children: [
//                       Text('Discount: $discount'),
//                     ],
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
import 'package:hotelbooking/home.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Define the items list based on the JSON structure
  final List<Map<String, dynamic>> items = [
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
      "name": "HarborHaven Hideaway",
      "price": "\$700/night",
      "location": "New York, USA",
      "rating": 4.8,
      "discount": "10% Off",
      "image":
          'https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg',
    },
    {
      "name": "Emerald Echo Oasis",
      "price": "Price not available", // Using a placeholder for the price
      "location": "New York, USA",
      "rating": 4.8,
      "discount": "10% Off",
      "image":
          'https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Bali - Indonesia',
        onSearch: (String) {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
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
                  );
                },
              ),
            ),
          ],
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
  }) : super(key: key);

  final String imagePath;
  final String title;
  final String location;
  final String price;
  final double rating;
  final String discount;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Image and icons stack
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row for title and icons (rating + favorite)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title aligned left
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      // Row for favorite icon and rating aligned top-right
                      Column(
                        children: [
                          // Favorite icon
                          Icon(
                            Icons.favorite, 
                            color: Colors.blue,
                            size: 24,
                          ),
                          SizedBox(height: 4), // Space between icon and rating
                          // Rating
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              Text(
                                rating.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(location),
                  Text(price),
                  Row(
                    children: [
                      Text('Discount: $discount'),
                    ],
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
