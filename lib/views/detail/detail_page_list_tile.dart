import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

import '../configure/theme.dart';

class DetailPageListTile extends ConsumerStatefulWidget {
  const DetailPageListTile({
    required this.index,
    required this.title,
    required this.timer,
    required this.options,
    Key? key,
  }) : super(key: key);
  final int index;
  final String title;
  final Timer timer;
  final TimerGroupOptions options;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      DetailPageListTileState();
}

class DetailPageListTileState extends ConsumerState<DetailPageListTile> {
  get title => widget.title;
  Timer get timer => widget.timer;
  int get index => widget.index;
  TimerGroupOptions get options => widget.options;
  String time = '';
  AlarmSounds alarm = AlarmSounds.sample;
  String alarmTitle = '';
  AlarmSounds bgm = AlarmSounds.sample;
  String bgmTitle = '';
  BackGroundImages image = BackGroundImages.sample;
  String imageTitle = BackGroundImages.sample.name;
  String notification = 'ON';
  bool isNotifyEnabled = true;

  @override
  void initState() {
    final timer = this.timer;

    time = intToTimeLeft(timer.time);
    alarmTitle = timer.soundPath;
    bgmTitle = timer.bgmPath;
    imageTitle = timer.imagePath;
    notification = timer.notification;
    super.initState();
  }

  Widget spacer() {
    return Column(
      children: const [
        SizedBox(height: 8),
        Divider(color: Themes.grayColor, height: 2),
        SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String format(Duration duration) =>
        '$duration'.split('.')[0].padLeft(8, '0');

    return Card(
      margin: const EdgeInsets.all(8),
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // if you need this
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: 180,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text((index + 1).toString()),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.timer_outlined),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    format(Duration(seconds: timer.time)),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.volume_up_outlined),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    alarmTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  spacer()
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.music_note_outlined),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    bgmTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  spacer()
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.image_outlined),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 130,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imageTitle),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.notifications_active_outlined),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    notification,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  spacer()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
