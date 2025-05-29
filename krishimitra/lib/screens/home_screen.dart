import 'package:flutter/material.dart';
import '../models/user_details.dart';
import 'weather_screen.dart';
import 'market_prices_screen.dart';
import '../services/user_service.dart';
import '../extensions/cropNameFormatter.dart';
import '../extensions/xmlParser.dart';
import 'package:remixicon/remixicon.dart';
import 'profile_setup_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen extends StatelessWidget {
  final UserDetails userDetails;

  const HomeScreen({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menu Button on the Left
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu), // Menu icon
              onSelected: (value) {
                switch (value) {
                  case 'Meet My Team':
                    Navigator.pushNamed(context, '/meet_my_team');
                    break;
                  case 'Contact Us':
                    Navigator.pushNamed(context, '/contact_us');
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  'Meet My Team',
                  'Contact Us',
                ].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
            const Spacer(), // Spacer to push the title to the center
            const Text(
              'KrishiMitram',
              textAlign: TextAlign.center,
            ),
            const Spacer(), // Spacer to ensure the title is centered
            // Logout Button on the Right
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _showLogoutDialog(context), // Logout function
            ),
          ],
        ),
      ),







      body: SingleChildScrollView( // Allows scrolling for the whole content
        child: Column(
          children: [
            _buildProfileCard(context),
            const SizedBox(height: 16), // Spacer
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20, // Spacing between cards
                crossAxisSpacing: 20, // Spacing between cards
                childAspectRatio: 0.8, // Adjusted aspect ratio for height
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildFeatureCard(context, index);
              },
            ),
            const SizedBox(height: 16), // Spacer before news updates
            _buildNewsUpdates(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'స్వాగతం,రైతు మిత్రమా ',
                  // '${userDetails.name}! / Welcome, ${userDetails.name}!',

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 8),
            Text('State: ${userDetails.state}'),
            Text('City: ${userDetails.city}'),
            Text('Crop: ${userDetails.crop}'),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSetupScreen(),
                  ),
                );

              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, int index) {
    final features = [
      {'title': 'Irrigation Control\nనీటి పారుదల', 'icon': Icons.water_drop},
      {'title': 'Weather Forecast\nవాతావరణం', 'icon': Icons.cloud},
      {'title': 'Crop Advice\nపంట సలహా', 'icon': Icons.spa},
      {'title': 'Disease Detection\nవ్యాధి గుర్తింపు', 'icon': Icons.bug_report},
      {'title': 'Market Prices\nమార్కెట్ ధరలు', 'icon': Icons.monetization_on},
      {'title': 'Latest News\nసరికొత్త సమాచారం', 'icon': Remix.newspaper_line},
    ];

    // Safely casting the values
    String normalizedTitle = (features[index]['title'] as String).split('\n')[0].trim();

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () async {
          debugPrint(normalizedTitle);


          switch (normalizedTitle) {
            case 'Irrigation Control':
            // Implement navigation for Irrigation Control
              Navigator.pushNamed(context, '/control_motor');
              print("Navigating to Irrigation Control");
              break;
            case 'Weather Forecast':
              String? cityCode = await getCityCode(userDetails.district, userDetails.city);
              debugPrint(cityCode);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeatherScreen(
                    cityCode: cityCode ?? (userDetails.state=='ఆంధ్ర ప్రదేశ్/Andhra Pradesh'?'43181':'43128'),
                    // cityCode ?? '43181',
                    // cityCode ?? (userDetails.state=='ఆంధ్ర ప్రదేశ్/Andhra Pradesh'?'43181':'43128'),
                    cityName: userDetails.city,
                  ),
                ),
              );
              break;
            case 'Market Prices':
              debugPrint(formatCropName(userDetails.district));
              debugPrint(formatCropName(userDetails.crop));
              Navigator.push(
                context,
                MaterialPageRoute(

                  builder: (context) => MarketPricesScreen(
                    state: userDetails.state=="ఆంధ్ర ప్రదేశ్/Andhra Pradesh"?'andhra-pradesh':'telangana',
                    crop:formatCropName(userDetails.crop),
                    raw_crop:userDetails.crop,
                    // crop: userDetails.crop.contains('/')?userDetails.crop.split('/')[1]:userDetails.crop,
                  ),
                ),
              );
              break;
            case 'Latest News':
              Navigator.pushNamed(context, '/news');
              break;
            case 'Disease Detection':
              Navigator.pushNamed(context,'/detect');
              break;
            case 'Crop Advice':
              Navigator.pushNamed(context,'/crop');
          // Add other cases as necessary
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(32.0), // Increased padding for larger cards
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(features[index]['icon'] as IconData, size: 45, color: Colors.greenAccent), // Increased icon size
              const SizedBox(height: 1),
              Text(
                features[index]['title'] as String, // Cast title correctly
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Increased font size
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsUpdates() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'తాజా వార్తలు / Latest Updates',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildNewsItem(
              'ప్రభుత్వ పథకం / Govt Scheme',
              'New subsidy announced for drip irrigation',
              '2 hours ago',
            ),
            _buildNewsItem(
              'మార్కెట్ అప్డేట్ / Market Update',
              'Cotton prices increased by 5%',
              '5 hours ago',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem(String title, String description, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(description),
          Text(time, style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await UserPreferences.clearUserDetails();
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
