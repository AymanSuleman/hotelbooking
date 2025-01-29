import 'package:flutter/material.dart';

void main() {
  runApp(VacationHomeApp());
}

class VacationHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VacationHomeScreen(),
    );
  }
}

class VacationHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text("Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset("name",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vacation Home", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("123 Disney Way, Willingmington, WV 24921", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10),
                  Text("Choose an Option", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      OptionButton(text: "Hot Tub Access", isSelected: true),
                      SizedBox(width: 10),
                      OptionButton(text: "No Access", isSelected: false),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      OptionButton(text: "Breakfast", isSelected: true),
                      SizedBox(width: 10),
                      OptionButton(text: "No Breakfast", isSelected: false),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 10),
                  PriceRow(label: "Base Price", price: "\$156.00"),
                  PriceRow(label: "Taxes", price: "\$24.20"),
                  PriceRow(label: "Cleaning Fee", price: "\$40.00"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text("Book Now", style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  
  OptionButton({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text),
    );
  }
}

class PriceRow extends StatelessWidget {
  final String label;
  final String price;

  PriceRow({required this.label, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
