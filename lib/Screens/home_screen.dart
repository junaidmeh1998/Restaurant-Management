import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getUserInfo() async {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    var userinfo = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userid)
        .get(); // Use .get() to fetch a single document snapshot

    if (userinfo.exists) {
      Map<String, dynamic> userData = userinfo.data() as Map<String, dynamic>;

      setState(() {
        userRole = userData['role'];
      });
    } else {
      // Handle the case where the document doesn't exist
      setState(() {
        userRole = ''; // or set it to some default value
      });
    }
  }

  @override
  void initState() {
    getUserInfo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nextScreen(context, Widget screenName) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screenName),
      );
    }

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.exit_to_app))
      ], automaticallyImplyLeading: false, backgroundColor: Colors.lightBlue),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 5),
            children: [
              for (int i = 0; i < moduleNames.length; i++)
                InkWell(
                  onTap: () {
                    nextScreen(context, screenNames[i]);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: colorList[i],
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      moduleNames[i],
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
