import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  Reports({Key? key, required this.eventName, required this.appbarcolor})
      : super(key: key);
  String eventName;
  Color appbarcolor;
  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
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
      body: const Center(
        child: Text("Work in Progress in this module"),
      ),
    );
  }
}
