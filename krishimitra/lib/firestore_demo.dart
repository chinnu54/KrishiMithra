// firestore_demo.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirestoreDataDemo extends StatefulWidget {
  const FirestoreDataDemo({super.key});

  @override
  _FirestoreDataDemoState createState() => _FirestoreDataDemoState();
}

class _FirestoreDataDemoState extends State<FirestoreDataDemo> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getAndPrintData() async {
    try {
      // Check if the user is authenticated (optional for now, but good practice for future)
      // User? user = FirebaseAuth.instance.currentUser;
      // if (user == null) {
      //   print('User is not authenticated');
      //   // Handle authentication, e.g., redirect to login screen
      //   return;
      // }

      // UserCredential userCredential = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(
      //     email: 'test@sis.com',
      //     password: 'Sis@1234');

      // Get a single document
      print('\n--- Single Document ---');
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('1XEwH8ROabbOq60xFmc9jsKNBVz1')
          .get();

      if (docSnapshot.exists) {
        print('Document Data: ${docSnapshot.data()}');
        print('Data Type: ${docSnapshot.data()?.runtimeType}');
      } else {
        print('Document does not exist');
      }

      // Get collection data
      print('\n--- Collection Data ---');
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('users').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          print('\nDocument ID: ${doc.id}');
          print('Document Data: ${doc.data()}');
          print('Data Type: ${doc.data().runtimeType}');

          // Print individual fields and their types
          Map<String, dynamic> data = doc.data();
          data.forEach((key, value) {
            print('Field: $key, Value: $value, Type: ${value.runtimeType}');
          });
        }
      } else {
        print('No documents found in the collection');
      }
    } catch (e) {
      print('Error: $e');
      if (e is FirebaseException) {
        switch (e.code) {
          case 'permission-denied':
            print('Permission denied. Check your Firestore rules.');
            break;
          case 'unavailable':
            print('Network error. Check your internet connection.');
            break;
          case 'not-found':
            print('Document or collection not found.');
            break;
          case 'invalid-argument':
            print('Invalid query. Check your query configuration.');
            break;
          case 'resource-exhausted':
            print('Quota exceeded. Check your Firestore usage.');
            break;
          default:
            print('An unexpected error occurred: ${e.message}');
        }
      } else {
        print('An unexpected error occurred: $e');
      }
    }
  }

// Real-time data stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersStream() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Data Demo'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: getAndPrintData,
            child: const Text('Print Firestore Data'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getUsersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Stream Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Print stream data
                print('\n--- Stream Data Update ---');
                snapshot.data?.docs.forEach((doc) {
                  print('Document ID: ${doc.id}');
                  print('Data: ${doc.data()}');
                  print('Type: ${doc.data().runtimeType}');
                });

                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data = doc.data();
                    return ListTile(
                      title: Text(data['name'] ?? 'No name'),
                      subtitle: Text(doc.id),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
