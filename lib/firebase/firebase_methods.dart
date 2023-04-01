import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      print(item.name);
    }
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

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('そのアカウントは他の認証方法で既に登録されています。',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('認証情報にアクセス中にエラーが発生しました。再試行してください。',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('エラーが発生しました。再試行してください。',
                style: TextStyle(color: Colors.white)),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }

      return user;
    }
    return null;
  }

  User? getUser() {
    final auth = FirebaseAuth.instance;
    return auth.currentUser;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('エラーが発生しました。再試行してください。',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}
