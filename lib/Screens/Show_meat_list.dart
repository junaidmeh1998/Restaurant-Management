import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowingMeatItems extends StatefulWidget {
  ShowingMeatItems(
      {Key? key, required this.eventName, required this.appbarcolor})
      : super(key: key);
  String eventName;
  Color appbarcolor;
  @override
  State<ShowingMeatItems> createState() => _ShowingMeatItemsState();
}

class _ShowingMeatItemsState extends State<ShowingMeatItems> {
  var fireStoreDb = FirebaseFirestore.instance.collection('Meat').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.eventName,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: widget.appbarcolor,
      ),
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
          height: 190,
          child: Card(
            elevation: 9,
            color: Color(0xFF4DB6AC),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Container(
                            height: 150,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    snapshot.docs[index]["imageLink"]),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
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
                                      snapshot.docs[index]["name"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      "Price: ${snapshot.docs[index]["price"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      "Quantity: ${snapshot.docs[index]["quantity"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      "Category: ${snapshot.docs[index]["category"]}",
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
