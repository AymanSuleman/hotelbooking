// import 'package:flutter/material.dart';
// import 'package:hotelbooking/home.dart';

// void main() {
//   runApp(HistoryApp());
// }

// class HistoryApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HistoryScreen(),
//     );
//   }
// }

// class HistoryScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> items = List.generate(
//     6,
//     (index) => {
//       "title": "Title",
//       "subtext": "Subtext",
//       "price": "\$11.00",
//       "image": "https://via.placeholder.com/150", // Replace with actual images
//     },
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Bali - Indonesia',
//         onSearch: (String) {},
//       ),
//       // appBar: AppBar(
//       //   title: Text("History"),
//       //   actions: [
//       //     IconButton(
//       //       icon: Icon(Icons.shopping_cart),
//       //       onPressed: () {},
//       //     ),
//       //   ],
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Your Booking history is here",
//               style: TextStyle(color: Colors.grey, fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 5),
//                     child: ListTile(
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(8.0),
//                         child: Image.network(
//                           item["image"],
//                           width: 50,
//                           height: 50,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       title: Text(item["title"],
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       subtitle: Text(item["subtext"]),
//                       trailing: Text(
//                         item["price"],
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       onTap: () {},
//                     ),
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

import 'package:flutter/material.dart';
import 'package:hotelbooking/home.dart';

void main() {
  runApp(HistoryApp());
}

class HistoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HistoryScreen(),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      "title": "The Reefs",
      "subtext": "A beautiful resort by the beach.",
      "price": "\$200.00",
      "image":
          "https://t4.ftcdn.net/jpg/06/32/20/07/240_F_632200724_WuOGPlu1XfDjqUinsBGzHXaa8TVtdqD9.jpg",
    },
    {
      "title": "Devils Cove",
      "subtext": "A hidden gem with breathtaking views.",
      "price": "\$250.00",
      "image":
          "https://t3.ftcdn.net/jpg/03/21/78/98/240_F_321789819_Jyv66AM5PoY0j9tZzjkB1c807zQQXtZh.jpg",
    },
    {
      "title": "Beachside Retreat",
      "subtext": "Stay close to the ocean and unwind.",
      "price": "\$150.00",
      "image":
          "https://t3.ftcdn.net/jpg/09/79/53/60/240_F_979536087_YmIDF56Qtz7i1JiEXv3eXzI5gitM8BvS.jpg",
    },
    {
      "title": "Mountain Escape",
      "subtext": "Experience serenity with mountain views.",
      "price": "\$180.00",
      "image":
          "https://as2.ftcdn.net/v2/jpg/09/64/96/87/1000_F_964968792_O79xKuKm2BYv0dFoQ4b1ryvzd4RgNeRD.jpg",
    },
    {
      "title": "Sunset Villas",
      "subtext": "A romantic getaway for couples.",
      "price": "\$300.00",
      "image":
          "https://t3.ftcdn.net/jpg/06/62/45/33/240_F_662453349_0F0wU2lQ4wDaVnCjSzoNmWsRHv8kC9go.jpg",
    },
    {
      "title": "Ocean Breeze",
      "subtext": "Perfect for a relaxing beach holiday.",
      "price": "\$220.00",
      "image":
          "https://t4.ftcdn.net/jpg/04/63/09/29/240_F_463092963_FwxvzwP8DtsgEZwDqlOdIjDUnyBd62PV.jpg",
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Booking history is here",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          item["image"],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(item["title"],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(item["subtext"]),
                      trailing: Text(
                        item["price"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
                    ),
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
