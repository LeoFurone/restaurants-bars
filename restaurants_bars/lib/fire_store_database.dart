import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStoreDatabase {
  String? downloadUrl;

  Future getData(String path) async {
    try {
      downloadUrl = await FirebaseStorage.instance.ref().child(path).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }
}