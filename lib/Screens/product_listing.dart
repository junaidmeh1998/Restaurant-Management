import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screens/login_Screen.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import 'meat_functions.dart';

class ProductListing extends StatefulWidget {
  ProductListing({Key? key, required this.eventName, required this.appbarcolor})
      : super(key: key);
  String eventName;
  Color appbarcolor;

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  final formkey = GlobalKey<FormState>();
  Uint8List? _image;

  pickImag(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    print('No Image is selected');
  }

  void selectImage() async {
    Uint8List img = await pickImag(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    void saveProfile() async {
      if (formkey.currentState!.validate()) {
        String name = nameController.text;
        String price = priceController.text;
        String quantity = quantityController.text;
        String category = categoryController.text;
        String resp = await StoreDat()
            .saveDat(
                name: name,
                price: price,
                file: _image!,
                quantity: quantity,
                category: category)
            .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Product added'),
                    behavior: SnackBarBehavior.floating,
                    elevation: 0,
                    backgroundColor: widget.appbarcolor,
                  ),
                ));
      }
    }

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
          child: Center(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://www.pngitem.com/pimgs/m/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                              onPressed: selectImage,
                              icon: Icon(Icons.add_a_photo)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    textfield(
                        controller: nameController,
                        icon: Icons.production_quantity_limits,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter product name");
                          }
                          return null;
                        },
                        iconcolor: Colors.black,
                        hintext: 'Product Name'),
                    const SizedBox(
                      height: 24,
                    ),
                    textfield(
                        controller: priceController,
                        icon: Icons.monetization_on,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter valid price";
                          }
                          if (!RegExp("^(0|[1-9][0-9]*)").hasMatch(value)) {
                            return "only numeric values";
                          }
                          return null;
                        },
                        iconcolor: Colors.black,
                        hintext: 'Product Price'),
                    const SizedBox(
                      height: 24,
                    ),
                    textfield(
                        controller: quantityController,
                        icon: Icons.production_quantity_limits,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Product quantity";
                          }
                          if (!RegExp("^(0|[1-9][0-9]*)").hasMatch(value)) {
                            return "only numeric values";
                          }
                          return null;
                        },
                        iconcolor: Colors.black,
                        hintext: 'Quantity'),
                    const SizedBox(
                      height: 24,
                    ),
                    textfield(
                        controller: categoryController,
                        icon: Icons.category,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter a Category name";
                          }
                          // if (!RegExp("/^[A-Z][a-z]").hasMatch(value)) {
                          //   return "First letter Must be Capital";
                          // }
                          return null;
                        },
                        iconcolor: Colors.black,
                        hintext: 'Category'),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomButton(
                        text: 'List Product',
                        onTap: saveProfile,
                        color: widget.appbarcolor)
                  ],
                )),
          )),
        ));
  }
}
