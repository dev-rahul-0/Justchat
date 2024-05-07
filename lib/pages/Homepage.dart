import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projecknew/newsApp/screens/splashScreen.dart';
import 'package:projecknew/pages/chat_page.dart';
import 'package:projecknew/pages/service/auth/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JustChat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black87,
              ))
        ],
      ),
      body: _buildUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SplashScreen()),
          );
        },
        backgroundColor: Colors.grey.shade100,
        child: const Icon(
          Icons.newspaper,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final users = snapshot.data!.docs;
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index].data() as Map<String, dynamic>;
            final userEmail = userData['email'] as String;
            final userId = userData['uid'] as String;
            final userName = userData['username'] as String;
            if (_auth.currentUser!.email != userEmail) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade100,
                  ),
                  child: ListTile(
                    title: Text(userName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            receiverUserEmail: userEmail,
                            receverUserId: userId,
                            User: userName,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}
