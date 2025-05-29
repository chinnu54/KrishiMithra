// import 'package:flutter/material.dart';
//
// class ContactUsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contact Us'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Get in Touch',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'If you have any questions or feedback, feel free to reach out to us.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//
//             // Name Field
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Name',
//                 hintText: 'Enter your name',
//               ),
//             ),
//             SizedBox(height: 10),
//
//             // Email Field
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Your Email',
//                 hintText: 'Enter your email',
//               ),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 10),
//
//             // Message Field
//             TextField(
//               maxLines: 4,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Your Message',
//                 hintText: 'Write your message here...',
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // Submit Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Logic to send message
//                 },
//                 child: Text('Submit'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green, // Background color
//                 ),
//               ),
//             ),
//
//             // Additional contact information
//             SizedBox(height: 20),
//             Text(
//               'Contact Information:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text('Name : KANAKALA SANDEEP KUMAR'),
//             Text('Designation: Founder & Developer'),
//             Text('Phone: +919346229667'),
//             Text('Email: kanakala.sis06@gmail.com'),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.green[700], // A more earthy, darker green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Use SingleChildScrollView for scrolling on small screens
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get in Touch',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
              SizedBox(height: 10),
              Text(
                'If you have any questions or feedback, feel free to reach out to us.',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              SizedBox(height: 20),

              // Name Field
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  labelStyle: TextStyle(color: Colors.green),
                  hintStyle: TextStyle(color: Colors.green[300]),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Email Field
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Email',
                  hintText: 'Enter your email',
                  labelStyle: TextStyle(color: Colors.green),
                  hintStyle: TextStyle(color: Colors.green[300]),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),

              // Message Field
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Message',
                  hintText: 'Write your message here...',
                  labelStyle: TextStyle(color: Colors.green),
                  hintStyle: TextStyle(color: Colors.green[300]),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 18), // Larger text for better readability
                  ),
                ),
              ),

              // Additional contact information
              SizedBox(height: 93),
              Text(
                'Contact Information:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
              SizedBox(height: 10),
              Text('Name: KANAKALA SANDEEP KUMAR', style: TextStyle(fontSize: 16)),
              Text('Designation: Founder & Developer', style: TextStyle(fontSize: 16)),
              Text('Phone: +919346229667', style: TextStyle(fontSize: 16)),
              Text('Email: kanakala.sis06@gmail.com', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
