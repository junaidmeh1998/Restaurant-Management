import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StaffScreen extends StatefulWidget {
  StaffScreen({super.key, required this.eventName, required this.appbarcolor});
  String eventName;
  Color appbarcolor;

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: widget.appbarcolor,
        title: Text(
          widget.eventName,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("No User Right Now"),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final document =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(document['name']),
                    subtitle: Text(
                      document['role'],
                      style: TextStyle(color: widget.appbarcolor),
                    ),
                  );
                });
          }),
    );
  }
}
