import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/domein/provider/audioProvider.dart';
import 'package:timer_group/views/components/audio_play_button.dart';
import 'package:timer_group/views/configure/theme.dart';

class AlarmInputDialog extends ConsumerStatefulWidget {
  const AlarmInputDialog({
    required this.sounds,
    Key? key,
  }) : super(key: key);

  final List<Sound> sounds;

  @override
  AlarmInputDialogState createState() => AlarmInputDialogState();
}

class AlarmInputDialogState extends ConsumerState<AlarmInputDialog> {
  List<Sound> get sounds => widget.sounds;
  Sound? selectedSound;

  @override
  void initState() {
    super.initState();
    selectedSound = sounds.first;
  }

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
    final audioProvider = ref.watch(audioPlayingProvider.notifier);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
              Icon(Icons.volume_up_outlined),
              SizedBox(
                width: 8,
              ),
              Text('アラーム音')
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
          itemCount: sounds.length,
          controller: ScrollController(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: ((context, index) => Container(
                height: 50,
                color: Colors.white,
                child: RadioListTile(
                  title: AudioPlayButton(
                    sound: sounds[index],
                    player: audioProvider.player,
                  ),
                  value: sounds[index],
                  groupValue: selectedSound,
                  onChanged: (value) => _onRadioSelected(value),
                ),
              )),
        ),
      ),
    );
  }
}
