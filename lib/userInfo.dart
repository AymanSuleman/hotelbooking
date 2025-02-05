import 'package:flutter/material.dart';
import 'package:hotelbooking/bookingprocess.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserInfo(),
  ));
}

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectedGender = "Male";
  String selectedCountry = "United States";

  final List<String> genders = ["Male", "Female", "Other"];
  // final List<String> countries = ["United States", "Canada", "United Kingdom", "India"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Book Hotel"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Information Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            buildTextField("Name", nameController, "John Doe"),
            buildTextField("Email", emailController, "example@gmail.com"),
            buildDropdownField("Gender", selectedGender, genders,
                (String? newValue) {
              setState(() => selectedGender = newValue!);
            }),
            buildTextField("phone No.", phoneController, '+91'),

            // buildPhoneNumberField(),
            // buildDropdownField("Country", selectedCountry, countries, (String? newValue) {
            //   setState(() => selectedCountry = newValue!
            //   );
            // }),
            Spacer(),
            buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget buildDropdownField(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: onChanged,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

//   Widget buildPhoneNumberField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
// children: [
//         Text("Phone Number", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//         SizedBox(height: 5),
//         TextField(
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.grey[200],
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
//           ),
//           // initialCountryCode: "US",
//           onChanged: (phone) {
//             phoneController.text = phone.completeNumber;
//           },
//         ),
//       ],
//     );
//   }

  Widget buildContinueButton() {
    return ElevatedButton(
      onPressed: () {
        print("Name: ${nameController.text}");
        print("Email: ${emailController.text}");
        print("Gender: $selectedGender");
        print("Phone: ${phoneController.text}");
        print("Country: $selectedCountry");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentMethodsScreen(),
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
            child: Text("Continue",
                style: TextStyle(fontSize: 18, color: Colors.white))),
      ),
    );
  }
}
