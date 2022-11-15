import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FirebaseMethods {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> getImageUrls() async {
    final storageRef = FirebaseStorage.instance.ref().child("images");
    final listResult = await storageRef.listAll();
    final List<String> imageUrlList = [];

    for (var prefix in listResult.prefixes) {
      final ref = storage.ref().child('images/$prefix');
      final String url = await ref.getDownloadURL();
      //final String url = await prefix.getDownloadURL();
      print(url);
      imageUrlList.add(url);
    }
    for (var item in listResult.items) {
      // The items under storageRef.
      final ref = storage.ref().child('${item.fullPath}');
      final String url = await ref.getDownloadURL();
      imageUrlList.add(url.toString());
    }
    print(imageUrlList);
    return imageUrlList;
  }

  Future<List<Image>> getImages() async{
    final urls = await getImageUrls();
    final List<Image> imageList = [];
    for (var url in urls) {
      final img = Image(image: CachedNetworkImageProvider(url));
      imageList.add(img);
    }

    return imageList;
  }

}
