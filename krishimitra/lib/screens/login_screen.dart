import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import '../services/user_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false;
  bool _obscureTextPassword = true;

  Future<void> loginWithEmailAndPassword(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Check if email is verified, except for 'test@sis.com'
      if (userCredential.user?.email != 'test@sis.com' &&
          !userCredential.user!.emailVerified) {
        // Show dialog for email verification
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Email Not Verified'),
            content: Text('Please verify your email before continuing.'),
            actions: [
              TextButton(
                onPressed: () async {
                  // Resend verification email
                  await userCredential.user!.sendEmailVerification();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Verification email sent! Please check your inbox.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Text('Resend Email'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return; // Exit if email is not verified
      }

      // If verified or if it's the excluded email, navigate to home or next screen
      final userId = userCredential.user?.uid;

      if (userId != null) {
        try {
          // Check if user details exist in SharedPreferences
          final hasUserDetails = await UserPreferences.hasUserDetails();

          if (hasUserDetails) {
            // If user details exist, get them and navigate to home
            final userDetails = await UserPreferences.getUserDetails();
            if (userDetails != null) {
              if (mounted) {
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                  arguments: userDetails,
                );
              }
            } else {
              // User details couldn't be retrieved, go to profile setup
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/profile_setup');
              }
            }
          } else {
            // No user details found, navigate to profile setup
            if (mounted) {
              Navigator.pushReplacementNamed(context, '/profile_setup');
            }
          }
        } catch (e) {
          print('Error checking user details: $e');
          // If there's an error checking user details, go to profile setup
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/profile_setup');
          }
        }
      } else {
        throw Exception('User ID is null after authentication');
      }

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> googleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final UserCredential userCredential = await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ),
      );


      final userId = userCredential.user?.uid;

      if (userId != null) {
        try {
          final hasUserDetails = await UserPreferences.hasUserDetails();

          if (hasUserDetails) {
            final userDetails = await UserPreferences.getUserDetails();

            if (userDetails != null) {
              if (mounted) {
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                  arguments: userDetails,
                );
              }
            } else {
              // User details couldn't be retrieved, go to profile setup
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/profile_setup');
              }
            }
          } else {
            // No user details found, navigate to profile setup
            if (mounted) {
              Navigator.pushReplacementNamed(context, '/profile_setup');
            }
          }
        } catch (e) {
          print('Error checking user details: $e');
          // If there's an error checking user details, go to profile setup
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/profile_setup');
          }
        }
      } else {
        throw Exception('User ID is null after authentication');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<void> navigateToForgotPassword() async {
    // Navigate to your Forgot Password page here
    Navigator.pushNamed(context, '/forgot'); // Ensure this route is defined in your app
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/farm_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
        ),

        // color: Color(0xFF2C2C2C), // Dark background color
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white, // Light color for the card
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App Title
                    Text(
                      'KrishiMithra',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    // App Slogan
                    SizedBox(height: 0.0000001),
                    Text(
                      'Be a Smart Farmer',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,),
                        textAlign:TextAlign.right

                      ),
                    // ),

                    // Lock Icon
                    // Icon(Icons.lock, size: 50, color: Colors.black54),
                    // SizedBox(height: 20),
                    // Text(
                    //   'Welcome Back',
                    //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    //   textAlign: TextAlign.center,
                    // ),
                    SizedBox(height:20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email / ఇమెయిల్',
                        prefixIcon: Icon(Icons.email, color: Color(0xFF333333)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureTextPassword,
                      decoration: InputDecoration(
                        labelText: 'Password / పాస్‌వర్డ్',
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF333333)),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureTextPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureTextPassword = !_obscureTextPassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns buttons to the two ends
                      children: [
                         _isLoading
                            ? LoadingAnimationWidget.stretchedDots(
                          // leftDotColor: Colors.blue,
                          //  rightDotColor: Colors.green,// Customize the color
                          color: Colors.blueAccent,
                           size: 50,           // Customize the size
                        )
                            : Expanded(
                          child: ElevatedButton(
                            onPressed: () => loginWithEmailAndPassword(context),
                            child: Text('Sign In', style: TextStyle(fontSize: 18, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.green, // Green for the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4), // Spacer between buttons
                        TextButton(
                          onPressed: navigateToForgotPassword, // Navigate to Forgot Password
                          child: Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),

                    SizedBox(height: 20), // Space before the Google sign-in button
                    Text('Or continue with', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8), // Space before Google sign-in button
                    ElevatedButton(
                      onPressed: googleSignIn, // Google Sign-In method
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('assets/Logos/google.png'),
                            // width: 100,
                            height: 24,
                          ),
                          // SvgPicture.network(
                          //   'https://www.svgrepo.com/show/475656/google-color.svg',
                          //   height: 24.0,
                          // ),
                          SizedBox(width: 4),
                          Text('Sign in with Google', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: Colors.white, // Google red color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child:
                    Text('Not a member? Sign Up', style: TextStyle(color: Colors.blue))),
                  ],
                ),

              ]),
            ),
          ),
        ),
      ),
      ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
