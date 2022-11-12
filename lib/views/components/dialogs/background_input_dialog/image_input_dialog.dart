import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/views/components/dialogs/background_input_dialog/video_imput_dialog.dart';
import 'package:timer_group/views/components/toggle_text_button.dart';
import 'package:timer_group/views/configure/theme.dart';

class ImageInputDialog extends ConsumerStatefulWidget {
  ImageInputDialog({Key? key}) : super(key: key);

  @override
  ImageInputDialogState createState() => ImageInputDialogState();
}

class ImageInputDialogState extends ConsumerState<ImageInputDialog> {
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

  _onVideoSelected() {
    isImageSelected = false;
    setState(() {});
  }

  _onIamgeSelected() {
    isImageSelected = true;
    setState(() {});
  }

  Widget content() {
    if (isImageSelected) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
            itemCount: images.length,
            controller: ScrollController(),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: ((context, index) => RadioListTile(
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
                      height: 50,
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
    } else {
      return VideoImputDialog();
    }
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
            Navigator.pop<BackGroundImages>(context, selectedImage);
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
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.image_outlined),
                  SizedBox(
                    width: 8,
                  ),
                  Text('背景')
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
          Divider(
            height: 16,
          ),
          ToggleTextButton(
            onLeftSelected: _onIamgeSelected,
            onRightSelected: _onVideoSelected,
          ),
        ],
      ),
      content: content(),
    );
  }
}
