import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screens/Show_Purchase_data.dart';
import 'package:hotelmanagement/Screens/login_Screen.dart';
import 'package:hotelmanagement/Screens/purchase_screen.dart';

class AddAndSeePurchseDetail extends StatefulWidget {
  AddAndSeePurchseDetail(
      {Key? key, required this.eventName, required this.appbarcolor})
      : super(key: key);
  String eventName;
  Color appbarcolor;
  @override
  State<AddAndSeePurchseDetail> createState() => _AddAndSeePurchseDetailState();
}

class _AddAndSeePurchseDetailState extends State<AddAndSeePurchseDetail> {
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
        body: SingleChildScrollView(
            child: Column(children: [
          divider(),
          CustomButton(
              text: "Add Purchase",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PurchaseScreen(
                              eventName: 'Add Purchase',
                              appbarcolor: const Color(0xFF81C784),
                            )));
              },
              color: widget.appbarcolor),
          divider(),
          CustomButton(
              text: "Show Purchase",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowPurchaseScreen(
                            eventName: "Sales Purchase",
                            appbarcolor: const Color(0xFF81C784))));
              },
              color: widget.appbarcolor)
        ])));
  }

  Widget divider() {
    return Container(
      height: 5,
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}
