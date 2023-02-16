import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/domein/models/sound.dart';

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
          semanticLabel: url,
        ),
      );
    }
    print(imageList);
    return imageList;
  }

  Future<String> getSampleImageTitle() async {
    final storageRef = FirebaseStorage.instance.ref().child("images");
    final result = await storageRef.listAll();
    final ref = storage.ref().child(result.items.first.fullPath);
    final String url = await ref.getDownloadURL();

    return url;
  }

  Future<List<Sound>> getSoundEffects() async {
    final storageRef = FirebaseStorage.instance.ref().child("SE");
    final listResult = await storageRef.listAll();
    final List<Sound> sounds = [];

    for (var item in listResult.items) {
      // The items under storageRef.
      final ref = storage.ref().child(item.fullPath);
      final String url = await ref.getDownloadURL();
      sounds.add(Sound(name: item.name, url: url));
    }
    //print(sounds);
    return sounds;
  }

  Future<List<Sound>> getBGMs() async {
    final storageRef = FirebaseStorage.instance.ref().child("bgm");
    final listResult = await storageRef.listAll();
    final List<Sound> sounds = [];

    for (var item in listResult.items) {
      // The items under storageRef.
      final ref = storage.ref().child(item.fullPath);
      final String url = await ref.getDownloadURL();
      sounds.add(Sound(name: item.name, url: url));
    }
    //print(sounds);
    return sounds;
  }
}
