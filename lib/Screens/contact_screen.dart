// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomersScreen extends StatefulWidget {
  CustomersScreen(
      {super.key, required this.eventName, required this.appbarcolor});
  String eventName;
  Color appbarcolor;

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  launchWhatsapp(number) async {
    var phone = '$number';
    var url = 'https://wa.me/$phone';
    await launch(url);
  }

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
        stream:
            FirebaseFirestore.instance.collection('CustomerData').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No Customer right Now'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final document =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                final number = document['CellNo'].toString();
                return ListTile(
                    title: Text(document['CustomerName']),
                    subtitle: userRole == 'Manager' || userRole == 'Admin'
                        ? Text(number)
                        : const Text('You dont have access'),
                    trailing: userRole == 'Manager' || userRole == 'Admin'
                        ? TextButton(
                            onPressed: () {
                              launchWhatsapp(document['CellNo']);
                            },
                            child: const Text('Contact'),
                          )
                        : null);
              },
            );
          }
        },
      ),
    );
  }
}
