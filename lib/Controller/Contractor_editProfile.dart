import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContractorEditprofile {

  FirebaseStorage firebaseStorageObj = FirebaseStorage.instance;

  FirebaseFirestore firebaseFirestoreObj = FirebaseFirestore.instance;

  Future<void> uploadImage({
    required String fileName,
    required File selectedFile,
  }) async {
    log("upload Image to fireBase");
    await firebaseStorageObj.ref().child(fileName).putFile(selectedFile);
  }

  Future<String> downloadImage({required String fileName}) async {
    log("Download Image");
    String url = await firebaseStorageObj
        .ref()
        .child(fileName)
        .getDownloadURL();
    return url;
  }

  Future<void> addData({required Map<String, dynamic> data,required String? uid}) async {
    log("data added to database");
    await firebaseFirestoreObj.collection("Contractors").doc(uid).set(data);
  }
}
