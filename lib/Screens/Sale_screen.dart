import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screens/login_Screen.dart';

class SaleScreen extends StatefulWidget {
  SaleScreen({Key? key, required this.eventName, required this.appbarcolor})
      : super(key: key);
  String eventName;
  Color appbarcolor;
  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final productnameController = TextEditingController(); // Controllers

  final quantityController = TextEditingController();

  final priceController = TextEditingController();
  final customernameController = TextEditingController();
  final cellController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productnameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    customernameController.dispose();
    cellController.dispose();
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Container(
                  height: 500,
                  width: double.infinity,
                  child: Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(children: [
                          textfield(
                            controller: productnameController,
                            hintext: ' Product Name',
                            icon: Icons.production_quantity_limits,
                            iconcolor: Colors.black,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Product";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          textfield(
                            controller: quantityController,
                            hintext: ' Quantity ',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Quantity";
                              } else {
                                return null;
                              }
                            },
                            icon: Icons.production_quantity_limits,
                            iconcolor: Colors.black,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          textfield(
                            controller: priceController,
                            hintext: ' Price',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Price";
                              } else {
                                return null;
                              }
                            },
                            icon: Icons.monetization_on,
                            iconcolor: Colors.black,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          textfield(
                            controller: customernameController,
                            hintext: 'Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Name";
                              } else {
                                return null;
                              }
                            },
                            icon: Icons.person,
                            iconcolor: Colors.black,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          textfield(
                            controller: cellController,
                            hintext: 'Cell No',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Cell No";
                              } else {
                                return null;
                              }
                            },
                            icon: Icons.phone,
                            iconcolor: Colors.black,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          CustomButton(
                              text: "Add Sale",
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  // FirebaseFirestore.instance
                                  //     .collection('PurchasingDetail')
                                  //     .add({
                                  //   "ProductName": productnameController.text,
                                  //   "Quantity": quantityController.text,
                                  //   "Price": priceController.text,
                                  // });
                                  // FirebaseFirestore.instance
                                  //     .collection("PurchasePerson")
                                  //     .add({
                                  //   "CustomerName":
                                  //       customernameController.text,
                                  //   "CellNo": cellController.text,
                                  // });
                                  try {
                                    FirebaseFirestore.instance
                                        .collection('PurchasingDetail')
                                        .add({
                                      "ProductName": productnameController.text,
                                      "Quantity": quantityController.text,
                                      "Price": priceController.text,
                                    });
                                    FirebaseFirestore.instance
                                        .collection("PurchasePerson")
                                        .add({
                                      "CustomerName":
                                          customernameController.text,
                                      "CellNo": cellController.text,
                                    });
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Sales Added'),
                                        behavior: SnackBarBehavior.floating,
                                        elevation: 0,
                                        backgroundColor: widget.appbarcolor,
                                      ),
                                    );
                                    productnameController.clear();
                                    quantityController.clear();
                                    priceController.clear();
                                    customernameController.clear();
                                    cellController.clear();
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              },
                              color: widget.appbarcolor)
                        ])),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
