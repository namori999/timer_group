import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';

import 'package:timer_group/views/components/dialogs/audio_play_dialog/audio_play_button.dart';
import 'package:timer_group/views/configure/theme.dart';

class BgmInputDialog extends ConsumerStatefulWidget {
  const BgmInputDialog({required this.musics, Key? key}) : super(key: key);

  final List<Sound> musics;

  @override
  BgmInputDialogState createState() => BgmInputDialogState();
}

class BgmInputDialogState extends ConsumerState<BgmInputDialog> {
  List<Sound> get musics => widget.musics;
  Sound? selectedSound;
  String fileName = '';
  String strSePath = '';

  @override
  void initState() {
    super.initState();
    selectedSound = musics.first;
  }

  _onRadioSelected(value) {
    setState(() {
      selectedSound = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      insetPadding: const EdgeInsets.all(16),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.pop<Sound>(context, selectedSound);
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '決定',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.music_note_outlined),
              SizedBox(
                width: 8,
              ),
              Text('BGM')
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close_rounded)),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ListTile(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    io.File file = io.File(result.files.single.path!);
                    strSePath = file.path.toString();
                    fileName = file.path.split('/').last;
                    setState(() {
                      musics.insert(0, Sound(name: fileName, url: strSePath));
                    });
                  }
                },
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.library_music_outlined),
                    SizedBox(width: 8),
                    Text(
                      '+ ギャラリーから選ぶ',
                      style: TextStyle(color: Themes.grayColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: musics.length,
                controller: ScrollController(),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: ((context, index) => Ink(
                      height: 50,
                      color: Theme.of(context).dialogBackgroundColor,
                      child: RadioListTile(
                        title: AudioPlayButton(
                          sound: musics[index],
                          player: AudioPlayer(),
                        ),
                        value: musics[index],
                        groupValue: selectedSound,
                        onChanged: (value) => _onRadioSelected(value),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
