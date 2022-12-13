import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/views/components/audio_play_button.dart';
import 'package:timer_group/views/configure/theme.dart';

class BgmInputDialog extends ConsumerStatefulWidget {
  const BgmInputDialog({Key? key}) : super(key: key);

  @override
  BgmInputDialogState createState() => BgmInputDialogState();
}

class BgmInputDialogState extends ConsumerState<BgmInputDialog> {

  List<AlarmSounds> musics = AlarmSounds.values;
  AlarmSounds selectedSound = AlarmSounds.sample;

  Widget spacer() {
    return Column(
      children: const [
        SizedBox(height: 16),
        Divider(
          color: Themes.grayColor,
          height: 2,
        ),
        SizedBox(height: 16),
      ],
    );
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
            Navigator.pop<AlarmSounds>(context, selectedSound);
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
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          itemCount: musics.length,
          controller: ScrollController(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: ((context, index) => Container(
                height: 50,
                color: Colors.white,
                child: RadioListTile(
                  title: AudioPlayButton(sound: musics[index].name),
                  value: musics[index],
                  groupValue: selectedSound,
                  onChanged: (value) => _onRadioSelected(value),
                ),
              )),
        ),
      ),
    );
  }
}
