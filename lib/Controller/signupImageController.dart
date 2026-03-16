import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignupImageController {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //store image to Firestorage
  Future<String> uploadProfileImage(File imageFile, String userId) async {
    try {
      final ref = firebaseStorage.ref().child('profile_images/$userId.jpg');
      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();
      log("Image uploaded Url :$imageUrl");
      return imageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }

  //download image from storage
  Future<String> downloadImage(String userId) async {
    try {
      final ref = firebaseStorage.ref().child('profile_images/$userId.jpg');
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      log("Error fetching image URL: $e");
      return '';
    }
  }
// add 
  Future<void> addData(
    String collectionPath,
    String userId,
    Map<String, dynamic> obj,
  ) async {
    try {
      await firebaseFirestore.collection(collectionPath).doc(userId).set(obj);
      log("image saved in firestore at $collectionPath/$userId");
    } catch (e) {
      log("eroor to add data to firestore $collectionPath: $e");
      rethrow;
    }
  }

  Stream<Map<String, dynamic>?> getUserDataStream(String userId) {
    return firebaseFirestore.collection('users').doc(userId).snapshots().map((
      snapshot,
    ) {
      if (snapshot.exists) {
        return snapshot.data();
      }
      return null;
    });
  }
}
