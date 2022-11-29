import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/logic/time_converter.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

class OverTimeTile extends ConsumerStatefulWidget {
  const OverTimeTile({
    required this.title,
    required this.timer,
    required this.options,
    Key? key,
  }) : super(key: key);

  final String title;
  final Timer timer;
  final TimerGroupOptions options;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      DetailPageListTileState();
}

class DetailPageListTileState extends ConsumerState<OverTimeTile> {
  get title => widget.title;

  Timer get timer => widget.timer;

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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // if you need this
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.timer_outlined),
                      SizedBox(width: 16),
                      Text('最大時間'),
                    ],
                  ),
                  Text(
                    getFormattedTime(options, timer.time),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.volume_up_outlined),
                      SizedBox(width: 16),
                      Text('アラーム音'),
                    ],
                  ),
                  Text(
                    alarmTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.music_note_outlined),
                      SizedBox(width: 16),
                      Text('BGM'),
                    ],
                  ),
                  Text(
                    bgmTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.image_outlined),
                      SizedBox(width: 16),
                      Text('背景'),
                    ],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                   Icon(Icons.notifications_active_outlined),
                   SizedBox(
                    width: 16
                  ),
                      Text('通知')
                    ],
                  ),
                  Text(
                    '通知$notification',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
