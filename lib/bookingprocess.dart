import 'package:flutter/material.dart';
import 'package:hotelbooking/reviewSummery.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PaymentMethodsScreen(),
  ));
}

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String selectedPayment = "Cash"; // Default selected payment method

  final List<Map<String, dynamic>> paymentOptions = [
    {"title": "Cash", "icon": Icons.attach_money},
    {"title": "Wallet", "icon": Icons.account_balance_wallet},
    {"title": "Credit & Debit Card", "icon": Icons.credit_card},
    {"title": "Paypal", "icon": Icons.payment},
    {"title": "Apple Pay", "icon": Icons.apple},
    {"title": "Google Pay", "icon": Icons.account_balance},
  ];

  void onSelectPayment(String paymentMethod) {
    setState(() {
      selectedPayment = paymentMethod;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Payment Methods"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle("Cash"),
              buildPaymentOption("Cash", Icons.attach_money),
              buildSectionTitle("Wallet"),
              buildPaymentOption("Wallet", Icons.account_balance_wallet),
              buildSectionTitle("Credit & Debit Card"),
              buildCardPaymentOption("Credit & Debit Card", Icons.credit_card),
              buildSectionTitle("More Payment Options"),
              buildPaymentOption("Paypal", Icons.payment),
              buildPaymentOption("Apple Pay", Icons.apple),
              buildPaymentOption("Google Pay", Icons.account_balance),
              // Spacer(),
              SizedBox(
                height: 20,
              ),
              buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 5),
      child: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget buildPaymentOption(String title, IconData icon) {
    return GestureDetector(
      onTap: () => onSelectPayment(title),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.blue),
            SizedBox(width: 10),
            Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
            Radio<String>(
              value: title,
              groupValue: selectedPayment,
              onChanged: (value) => onSelectPayment(value!),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardPaymentOption(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Navigate to card details page (implement separately)
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.blue),
            SizedBox(width: 10),
            Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
            Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget buildConfirmButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewSummaryScreen(showContinueButton: true,),
            ));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
            child: Text("Confirm Payment",
                style: TextStyle(fontSize: 18, color: Colors.white))),
      ),
    );
  }
}
