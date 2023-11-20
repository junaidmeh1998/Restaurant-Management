import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hotelmanagement/constants.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreDat {
  String childName = DateTime.now().millisecondsSinceEpoch.toString();
  Future<String> uploadImageToStorage(String name, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveDat(
      {required String name,
      required String price,
      required String quantity,
      required String category,
      required Uint8List file}) async {
    String resp = "Some error occured";
    try {
      if (name.isNotEmpty || price.isNotEmpty || quantity.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('MeatImage', file);
        await FirebaseFirestore.instance.collection(category).add({
          'name': name,
          "price": price,
          "quantity": quantity,
          "imageLink": imageUrl,
          'category': category
        });
        resp = 'success';
        nameController.clear();
        priceController.clear();
        quantityController.clear();
        categoryController.clear();
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
