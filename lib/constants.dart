import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screens/Add_and_See_products.dart';
import 'package:hotelmanagement/Screens/Add_and_see_purchase_details.dart';
import 'package:hotelmanagement/Screens/Purchase_person_screen.dart';
import 'package:hotelmanagement/Screens/Reports.dart';
import 'package:hotelmanagement/Screens/add_and_see_sale_details.dart';
import 'package:hotelmanagement/Screens/add_user.dart';
import 'package:hotelmanagement/Screens/contact_screen.dart';
import 'package:hotelmanagement/Screens/staff_screen.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController roleController = TextEditingController();

TextEditingController priceController = TextEditingController();
TextEditingController quantityController = TextEditingController();
TextEditingController categoryController = TextEditingController();
List<Color> colorList = [
  Color(0xFFE57373), // Red
  Color(0xFF64B5F6), // Blue
  Color(0xFF81C784), // Green
  Color(0xFFFFD54F), // Yellow
  Color(0xFF9575CD), // Purple
  Color(0xFFFF8A65), // Orange
  Color(0xFFF06292), // Pink
  Color(0xFF4DB6AC), // Teal
  Color(0xFF8D6E63), // Brown
  Color(0xFF4DD0E1), // Cyan
  Color(0xFFAB47BC), // Lavender
  Color(0xFF8E24AA), // Maroon
  Color(0xFF5C6BC0), // Indigo
  Color(0xFFA1887F), // Olive
  Color(0xFFE57373), // Magenta
  Color(0xFF4DB6AC), // Turquoise
];
var moduleNames = [
  'Add User',
  'Sales',
  'Purchasing',
  'Customers',
  'Suppliers',
  'Reports',
  'Staff',
  'Product Listing'
];

List<Widget> screenNames = [
  AddUser(
    eventName: 'Add User',
    appbarcolor: const Color(0xFFE57373),
  ),
  AddAndShowSaleDetails(
      eventName: "Add and check sales", appbarcolor: Color(0xFF64B5F6)),
  AddAndSeePurchseDetail(
      eventName: "Add and check purchase", appbarcolor: Color(0xFF81C784)),
  CustomersScreen(
    eventName: 'Customers',
    appbarcolor: const Color(0xFFFFD54F),
  ),
  PurchasePersonDetail(
      eventName: "Suppliers Details", appbarcolor: Color(0xFF9575CD)),
  Reports(eventName: "Reports", appbarcolor: Color(0xFFFF8A65)),
  StaffScreen(
    eventName: 'Staff Screen',
    appbarcolor: const Color(0xFFF06292),
  ),
  AddAndShowProducts(
      eventName: "Add and check Products",
      appbarcolor: const Color(0xFF4DB6AC)),
];

String userRole = '';

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    exit(0);
    print("User logged out successfully.");
  } catch (e) {
    print("Error logging out: $e");
  }
}
