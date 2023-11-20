import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screens/Categories.dart';
import 'package:hotelmanagement/Screens/login_Screen.dart';
import 'package:hotelmanagement/Screens/product_listing.dart';

import '../constants.dart';

class AddAndShowProducts extends StatefulWidget {
  AddAndShowProducts(
      {Key? key, required this.eventName, required this.appbarcolor})
      : super(key: key);
  String eventName;
  Color appbarcolor;
  @override
  State<AddAndShowProducts> createState() => _AddAndShowProductsState();
}

class _AddAndShowProductsState extends State<AddAndShowProducts> {
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
          backgroundColor: widget.appbarcolor,
        ),
        body: userRole == 'Admin' || userRole == 'Manager'
            ? SingleChildScrollView(
                child: Column(children: [
                divider(),
                CustomButton(
                    text: "Add Product",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductListing(
                                    eventName: 'Product Listing',
                                    appbarcolor: const Color(0xFF4DB6AC),
                                  )));
                    },
                    color: widget.appbarcolor),
                divider(),
                CustomButton(
                    text: "Categories",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Categories(
                                  eventName: "Categories",
                                  appbarcolor: const Color(0xFF4DB6AC))));
                    },
                    color: widget.appbarcolor)
              ]))
            : const Center(
                child: Text('You Do not have Access to this Screen'),
              ));
  }

  Widget divider() {
    return Container(
      height: 5,
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}
