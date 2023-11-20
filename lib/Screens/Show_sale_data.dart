import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowSaleData extends StatefulWidget {
  ShowSaleData({Key? key, required this.eventName, required this.appbarcolor})
      : super(key: key);
  String eventName;
  Color appbarcolor;
  @override
  State<ShowSaleData> createState() => _ShowSaleDataState();
}

class _ShowSaleDataState extends State<ShowSaleData> {
  var fireStoreDb =
      FirebaseFirestore.instance.collection('ProductData').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.eventName,
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: widget.appbarcolor),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: fireStoreDb,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, int index) {
                  //  return Text(snapshot.data.docs[index]['description']);
                  return UsersAccessoriesCustomCard(
                      snapshot: snapshot.data, index: index);
                });
          }),
    );
  }
}

class UsersAccessoriesCustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;
  const UsersAccessoriesCustomCard({
    Key? key,
    required this.snapshot,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140,
          child: Card(
            elevation: 9,
            color: Color(0xFF64B5F6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                          child: Padding(
                              padding:
                                  EdgeInsets.only(left: 13, top: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      snapshot.docs[index]["ProductName"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      "Price: ${snapshot.docs[index]["Price"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      "Quantity: ${snapshot.docs[index]["Quantity"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
