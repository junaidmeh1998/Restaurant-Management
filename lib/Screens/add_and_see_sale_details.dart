import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screens/Sale_screen.dart';
import 'package:hotelmanagement/Screens/Show_sale_data.dart';
import 'package:hotelmanagement/Screens/login_Screen.dart';

class AddAndShowSaleDetails extends StatefulWidget {
  AddAndShowSaleDetails(
      {Key? key, required this.eventName, required this.appbarcolor})
      : super(key: key);
  String eventName;
  Color appbarcolor;
  @override
  State<AddAndShowSaleDetails> createState() => _AddAndShowSaleDetailsState();
}

class _AddAndShowSaleDetailsState extends State<AddAndShowSaleDetails> {
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
              text: "Add Sales",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SaleScreen(
                              eventName: 'Add Sales',
                              appbarcolor: const Color(0xFF64B5F6),
                            )));
              },
              color: widget.appbarcolor),
          divider(),
          CustomButton(
              text: "Show Sale",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowSaleData(
                              eventName: 'Show Sale',
                              appbarcolor: const Color(0xFF64B5F6),
                            )));
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
