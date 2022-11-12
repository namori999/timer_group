import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/views/configure/theme.dart';

class VideoImputDialog extends ConsumerStatefulWidget {
  VideoImputDialog({Key? key}) : super(key: key);

  @override
  VideoImputDialogState createState() => VideoImputDialogState();
}

class VideoImputDialogState extends ConsumerState<VideoImputDialog> {
  List<BackGroundImages> images = BackGroundImages.values;
  BackGroundImages selectedImage = BackGroundImages.sample;
  bool isImageSelected = true;

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
      selectedImage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: ListView.separated(
            itemCount: images.length,
            controller: ScrollController(),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: ((context, index) =>
                RadioListTile(
                  title: Card(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/${images[index].name}.jpg'),
                        ),
                      ),
                      height: 300,
                      width: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          images[index].name,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  value: images[index],
                  groupValue: selectedImage,
                  onChanged: (value) => _onRadioSelected(value),
                ))),
      );
  }
}