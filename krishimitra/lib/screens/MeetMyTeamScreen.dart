import 'package:flutter/material.dart';

class MeetMyTeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meet My Team'),
        backgroundColor: Colors.green[700], // Matching color theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Two columns
          childAspectRatio: 0.538, // Aspect ratio of each grid item
          mainAxisSpacing: 60,
          crossAxisSpacing: 20,
          children: [
            _buildTeamMemberCard('Ashok Kumar Gorle', 'assets/Team/ashok.jpg', 'Developer'),
            _buildTeamMemberCard('Sandeep Kumar Kanakala', 'assets/Team/sandeep.jpg', 'Developer'),
            _buildTeamMemberCard('Sowmya Boggavarapu', 'assets/Team/sowmya.jpg', 'Content Writer'),
            _buildTeamMemberCard('Ram Naidu     Majji', 'assets/Team/ram.jpg', 'Technical Writer'),
          ],
        ),
      ),
    );
  }



  // Widget buildTeamMemberGrid(List<Map<String, String>> teamMembers) {
  //   return GridView.builder(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2, // Two items per row
  //       crossAxisSpacing: 10, // Horizontal gap between images
  //       mainAxisSpacing: 100, // Vertical gap between rows
  //     ),
  //     itemCount: teamMembers.length,
  //     itemBuilder: (context, index) {
  //       var member = teamMembers[index];
  //       return _buildTeamMemberCard(member['name']!, member['imagePath']!, member['role']!);
  //     },
  //   );
  // }








  Widget _buildTeamMemberCard(String name, String imagePath, String role) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image in its own row
          Container(
            height: 180, // Keep the mandated height
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),

          // Name in its own row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Role in its own row
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              role,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }































  //
  // Widget _buildTeamMemberCard(String name, String imagePath, String role) {
  //   return SizedBox(
  //     height: 280,
  //     child: Card(
  //       elevation: 7,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           // Image with rounded corners
  //           Container(
  //             height: 180,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(15),
  //                 topRight: Radius.circular(15),
  //               ),
  //               child: Image.asset(
  //                 imagePath,
  //                 width: double.infinity,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //
  //           // Name row with padding
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
  //             child: Text(
  //               name,
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.green[800],
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //
  //           // Role row with padding
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
  //             child: Text(
  //               role,
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: Colors.black,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //


  // Widget _buildTeamMemberCard(String name, String imagePath, String role) {
  //   return Card(
  //     elevation: 7,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         // Rounded corners for the image
  //         ClipRRect(
  //           borderRadius: BorderRadius.vertical(
  //             top: Radius.circular(15), // Top rounded corners
  //           ),
  //           child: Image.asset(
  //             imagePath,
  //             height: 180,
  //             width: double.infinity,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //
  //         // Box for name and role
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white, // Background color for the box
  //             borderRadius: BorderRadius.vertical(
  //               bottom: Radius.circular(15), // Bottom rounded corners
  //             ),
  //           ),
  //           padding: const EdgeInsets.all(8.0), // Padding inside the container
  //           child: Column(
  //             children: [
  //               // Name in its own row
  //               Text(
  //                 name,
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.green[800],
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //               const SizedBox(height: 4), // Space between name and role
  //               // Role in its own row
  //               Text(
  //                 role,
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   color: Colors.grey[600],
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }





































}
