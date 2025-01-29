import 'package:flutter/material.dart';

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
  final List<Map<String, dynamic>> items = List.generate(
    6,
    (index) => {
      "title": "Title",
      "subtext": "Subtext",
      "price": "\$11.00",
      "image": "https://via.placeholder.com/150", // Replace with actual images
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
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
                      title: Text(item["title"], style: TextStyle(fontWeight: FontWeight.bold)),
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
