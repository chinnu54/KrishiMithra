import 'package:KrishiMitram/screens/ForgotPasswordPage.dart';
import 'package:KrishiMitram/screens/News_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'screens/home_screen.dart';
import 'models/user_details.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/irrigationControl.dart';
import 'Screens/MeetMyTeamScreen.dart';
import 'Screens/ContactUsScreen.dart';
import 'package:provider/provider.dart';
import 'provider/network_checker_provider.dart';
import 'provider/news_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/SplashScreen.dart';
import 'Screens/disease_detection_screen.dart';
import 'Screens/crop_recommendation_screen.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);

  runApp(
    const MyApp(),

  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 690), // Adapt from the design size (e.g., Figma)
      minTextAdapt: true, // Automatically adjust text size
      splitScreenMode: true, // Support for split screens
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NewsProvider()), // Provide NewsProvider
            ChangeNotifierProvider(create: (_) => NetworkCheckerProvider()), // Provide NetworkCheckerProvider
          ],


          child:
          MaterialApp(

            title: 'Smart Irrigation System',
            initialRoute: '/splash',
            home: SplashScreen(),
            routes:{
              '/login': (context) => LoginPage(),
              '/signup': (context) => SignUpPage(),
              '/profile_setup': (context) => ProfileSetupScreen(),
              '/home': (context) {
                final UserDetails userDetails = ModalRoute.of(context)!.settings.arguments as UserDetails;
                return HomeScreen(userDetails: userDetails);
              },
              // '/home':(context) => HomeScreen(userDetails: UserDetails(
              //   // id: "USR123",
              //     name: "John Doe",
              //     email: "johndoe@example.com",
              //     state: "AP",
              //     city: "San Francisco",
              //     crop: "Wheat"
              // )),
              '/edit_profile': (context) {
                final UserDetails userDetails = ModalRoute.of(context)!.settings.arguments as UserDetails;
                return EditProfileScreen(userDetails: userDetails);
              },
              '/control_motor':(context) =>IrrigationControlScreen(),
              '/meet_my_team': (context) => MeetMyTeamScreen(), // Add your team screen
              '/contact_us': (context) => ContactUsScreen(), // Add your contact screen
              '/forgot':(context)=>ForgotPasswordPage(),
              '/news':(context)=>NewsPage(),
              '/detect':(context)=>WebViewScreen(),
              '/crop':(context)=>CropRecommendationScreen(),
            },
          ),
        );
      },
    );
  }
}



