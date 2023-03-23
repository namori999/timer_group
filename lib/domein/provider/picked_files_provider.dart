import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timer_group/domein/models/saved_image.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/firebase/firebase_methods.dart';
import 'package:timer_group/storage/sqlite.dart';

final pickedFilesRepositoryProvider =
    Provider((ref) => PickedFilesRepository(ref));

final pickedImagesProvider =
    FutureProvider((ref) => PickedFilesRepository(ref).getImages());

class PickedFilesRepository {
  PickedFilesRepository(this.ref);

  static const _pickedFilesDB = SqliteLocalDatabase.pickedFiles;
  final Ref ref;

  Future<List<SavedImage>> getImages() async =>
      await _pickedFilesDB.getImages();

  Future<List<Image>> getImageList() async {
    final savedImages = await getImages();
    final pickedImages = savedImages
        .map((i) => Image.file(
              io.File(i.url),
              semanticLabel: i.url,
            ))
        .toList()
        .reversed
        .toList(); //最新順で
    return pickedImages;
  }

  Future<List<Sound>> getBGMs() async => await _pickedFilesDB.getBGMs();

  Future<List<Sound>> getAlarms() async => await _pickedFilesDB.getAlarms();

  Future<void> addImage(SavedImage savedImage) async {
    return await _pickedFilesDB.insertImage(savedImage);
    //ref.refresh(timerGroupOptionsProvider(timerGroupOptions.id));
  }

  Future<void> addBGM(Sound sound) async {
    return await _pickedFilesDB.insertBGM(sound);
    //ref.refresh(timerGroupOptionsProvider(timerGroupOptions.id));
  }

  Future<void> addAlarm(Sound sound) async {
    return await _pickedFilesDB.insertAlarm(sound);
    //ref.refresh(timerGroupOptionsProvider(timerGroupOptions.id));
  }

  Future<void> checkFirstLaunch() async {
    final images = await getImages();
    final BGMs = await getBGMs();
    final alarms = await getAlarms();
    if(images.isEmpty) saveFirebaseImages();
    if(BGMs.isEmpty) saveFirebaseBGMs();
    if(alarms.isEmpty) saveFirebaseAlarms();
  }

  Future<void> saveFirebaseImages() async {
    final List<Image> firebaseImage = await FirebaseMethods().getImages();

    final String dir =
    await getTemporaryDirectory().then((value) => value.path);

    for (Image i in firebaseImage) {
      final io.File file =
      io.File(path.join(dir, path.basename(i.semanticLabel!)));
      final http.Response response =
      await http.get(Uri.parse(i.semanticLabel!));
      await file.writeAsBytes(response.bodyBytes);

      addImage(SavedImage(url: file.path, name: i.semanticLabel!));
    }

    ref.invalidate(pickedImagesProvider);
  }

  Future<void> saveFirebaseBGMs() async {
    final List<Sound> firebaseBgms = await FirebaseMethods().getBGMs();

    final String dir =
        await getTemporaryDirectory().then((value) => value.path);

    for (Sound s in firebaseBgms) {
      final io.File file =
          io.File(path.join(dir, path.basename(s.name)));
      final http.Response response =
          await http.get(Uri.parse(s.url));
      await file.writeAsBytes(response.bodyBytes);

      addBGM(Sound(url: file.path, name: s.name));
    }

    ref.invalidate(pickedImagesProvider);
  }

  Future<void> saveFirebaseAlarms() async {
    final List<Sound> alarms = await FirebaseMethods().getSoundEffects();

    final String dir =
    await getTemporaryDirectory().then((value) => value.path);

    for (Sound s in alarms) {
      final io.File file =
      io.File(path.join(dir, path.basename(s.name)));
      final http.Response response =
      await http.get(Uri.parse(s.url));
      await file.writeAsBytes(response.bodyBytes);

      addAlarm(Sound(url: file.path, name: s.name));
    }

    ref.invalidate(pickedImagesProvider);
  }

  Future<void> remove(String path) async {
    final images = await getImages();
    final String? id = images.where((i) => i.url == path).toList().first.id;
    if (id != null) await _pickedFilesDB.delete(id);
    //ref.refresh(timerGroupOptionsProvider(id));
  }
}
