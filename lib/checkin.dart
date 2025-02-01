// import 'package:flutter/material.dart';

// class CheckInCheckOutScreen extends StatefulWidget {
//   @override
//   _CheckInCheckOutScreenState createState() => _CheckInCheckOutScreenState();
// }

// class _CheckInCheckOutScreenState extends State<CheckInCheckOutScreen> {
//   DateTime? checkInDate;
//   DateTime? checkOutDate;

//   Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         if (isCheckIn) {
//           checkInDate = pickedDate;
//           if (checkOutDate != null && checkOutDate!.isBefore(checkInDate!)) {
//             checkOutDate = null;
//           }
//         } else {
//           checkOutDate = pickedDate;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select Dates"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Check In",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             GestureDetector(
//               onTap: () => _selectDate(context, true),
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   checkInDate == null
//                       ? "Select Check-in Date"
//                       : "${checkInDate!.day} ${_getMonthName(checkInDate!.month)} ${checkInDate!.year}",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Check Out",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             GestureDetector(
//               onTap: checkInDate == null
//                   ? null
//                   : () => _selectDate(context, false),
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: checkInDate == null ? Colors.grey[300] : Colors.grey[200],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   checkOutDate == null
//                       ? "Select Check-out Date"
//                       : "${checkOutDate!.day} ${_getMonthName(checkOutDate!.month)} ${checkOutDate!.year}",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: checkInDate != null && checkOutDate != null
//                     ? () {
//                         Navigator.pop(context, {
//                           'checkIn': checkInDate,
//                           'checkOut': checkOutDate,
//                         });
//                       }
//                     : null,
//                 child: Text("Confirm", style: TextStyle(fontSize: 18, color: Colors.white)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getMonthName(int month) {
//     List<String> months = [
//       "Jan", "Feb", "Mar", "Apr", "May", "Jun",
//       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
//     ];
//     return months[month - 1];
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: CheckInCheckOutScreen(),
//   ));
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HotelBookingScreen(),
//   ));
// }

// class HotelBookingScreen extends StatefulWidget {
//   @override
//   _HotelBookingScreenState createState() => _HotelBookingScreenState();
// }

// class _HotelBookingScreenState extends State<HotelBookingScreen> {
//   DateTime checkInDate = DateTime(2025, 10, 4);
//   DateTime checkOutDate = DateTime(2025, 11, 3);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Image.network(
//                 "https://source.unsplash.com/600x300/?hotel,room",
//                 height: 250,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               Positioned(
//                 top: 40,
//                 left: 16,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.arrow_back, color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.shade100,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Text(
//                           "10% Off",
//                           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Spacer(),
//                       RatingBarIndicator(
//                         rating: 4.5,
//                         itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
//                         itemCount: 5,
//                         itemSize: 20.0,
//                       ),
//                       Text(" (365 reviews)"),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "HarborHaven Hideaway",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "1012 Ocean Avenue, New York, USA",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                   SizedBox(height: 20),
//                   _buildDateSelector("Check In", checkInDate),
//                   SizedBox(height: 10),
//                   _buildDateSelector("Check Out", checkOutDate),
//                   SizedBox(height: 10),
//                   TextField(
//                     decoration: InputDecoration(
//                       hintText: "Enter note to owner",
//                       border: OutlineInputBorder(),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                     ),
//                   ),
//                   Spacer(),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                       onPressed: () {},
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                         child: Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateSelector(String title, DateTime date) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         SizedBox(height: 5),
//         Row(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
//               child: Text(
//                 "${date.day} ${_getMonth(date.month)}",
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(width: 10),
//             Text("${_getWeekday(date.weekday)}, ${date.day} ${_getMonth(date.month)}"),
//           ],
//         ),
//       ],
//     );
//   }

//   String _getMonth(int month) {
//     return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][month - 1];
//   }

//   String _getWeekday(int day) {
//     return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][day - 1];
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HotelBookingScreen(),
  ));
}

class HotelBookingScreen extends StatefulWidget {
  @override
  _HotelBookingScreenState createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  DateTime checkInDateTime = DateTime(2025, 10, 4, 14, 0);
  DateTime checkOutDateTime = DateTime(2025, 11, 3, 11, 0);

  Future<void> _selectDateTime(BuildContext context, bool isCheckIn) async {
    DateTime initialDate = isCheckIn ? checkInDateTime : checkOutDateTime;

    // Select Date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    // Select Time
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    if (pickedTime == null) return;

    setState(() {
      if (isCheckIn) {
        checkInDateTime = DateTime(
          pickedDate.year, pickedDate.month, pickedDate.day, 
          pickedTime.hour, pickedTime.minute,
        );
      } else {
        checkOutDateTime = DateTime(
          pickedDate.year, pickedDate.month, pickedDate.day, 
          pickedTime.hour, pickedTime.minute,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Discount and rating row
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "10% Off",
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                RatingBarIndicator(
                  rating: 4.5,
                  itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 20.0,
                ),
                Text(" (365 reviews)"),
              ],
            ),
            SizedBox(height: 10),

            // Hotel name and address
            Text(
              "HarborHaven Hideaway",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "1012 Ocean Avenue, New York, USA",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Check-in and Check-out selection
            _buildDateTimeSelector("Check In", checkInDateTime, true),
            SizedBox(height: 10),
            _buildDateTimeSelector("Check Out", checkOutDateTime, false),
            SizedBox(height: 10),

            // Note to Owner text field
            TextField(
              decoration: InputDecoration(
                hintText: "Enter note to owner",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
            Spacer(),

            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeSelector(String title, DateTime dateTime, bool isCheckIn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () => _selectDateTime(context, isCheckIn),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_getWeekday(dateTime.weekday)}, ${dateTime.day} ${_getMonth(dateTime.month)} ${dateTime.year}",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${_formatTime(dateTime.hour, dateTime.minute)}",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getMonth(int month) {
    return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][month - 1];
  }

  String _getWeekday(int day) {
    return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][day - 1];
  }

  String _formatTime(int hour, int minute) {
    String amPm = hour >= 12 ? "PM" : "AM";
    int formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return "$formattedHour:${minute.toString().padLeft(2, '0')} $amPm";
  }
}