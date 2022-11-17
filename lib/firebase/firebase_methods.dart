import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FirebaseMethods {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Image>> getImages() async {
    final storageRef = FirebaseStorage.instance.ref().child("images");
    final listResult = await storageRef.listAll();
    final List<Image> imageList = [];

    for (var item in listResult.items) {
      // The items under storageRef.
      final ref = storage.ref().child(item.fullPath);
      final String url = await ref.getDownloadURL();
      imageList.add(
        Image(
            image: CachedNetworkImageProvider(url),
            semanticLabel: item.fullPath),
      );
    }
    print(imageList);
    return imageList;
  }
}
