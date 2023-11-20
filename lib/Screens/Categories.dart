import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screens/Show_SeaFood_List.dart';
import 'package:hotelmanagement/Screens/Show_Vegatables_List.dart';
import 'package:hotelmanagement/Screens/Show_meat_list.dart';

class Categories extends StatefulWidget {
  Categories({Key? key, required this.eventName, required this.appbarcolor})
      : super(key: key);
  String eventName;
  Color appbarcolor;
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
          elevation: 5,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios, color: Colors.grey,),
          //   onPressed: () {
          //    // Navigator.of(context).pop();
          //   },
          // ),
        ),
        backgroundColor: const Color(0xFF4DB6AC),
        body: ListView(children: [
          Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, top: 10, bottom: 10, right: 5),
                      child: Row(
                        children: [
                          InkWell(
                            child: Column(children: [
                              Container(
                                height: 200,
                                width: 150,
                                child: Image.asset(
                                  "images/meatimage.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Meat Items",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))
                            ]),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowingMeatItems(
                                          eventName: "Meat List",
                                          appbarcolor:
                                              const Color(0xFF4DB6AC))));
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            child: Column(children: [
                              Container(
                                height: 200,
                                width: 150,
                                child: Image.asset(
                                  "images/seafood.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Sea Food Items",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))
                            ]),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowSeaFoodList(
                                          eventName: "SeaFood List",
                                          appbarcolor:
                                              const Color(0xFF4DB6AC))));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, top: 10, bottom: 10, right: 5),
                      child: Row(
                        children: [
                          InkWell(
                            child: Column(children: [
                              Container(
                                height: 200,
                                width: 150,
                                child: Image.asset(
                                  "images/images.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Vegatables Items",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))
                            ]),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowVegatableList(
                                          eventName: "Vegatable List",
                                          appbarcolor:
                                              const Color(0xFF4DB6AC))));
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ])
        ]));
  }
}
