import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timer_group/views/components/dialogs/background_input_dialog/video_imput_dialog.dart';
import 'package:timer_group/views/components/toggle_text_button.dart';
import 'package:timer_group/views/configure/theme.dart';

class ImageInputDialog extends StatefulWidget {
  ImageInputDialog(this.imageList, {Key? key}) : super(key: key);

  final List<Image> imageList;

  @override
  ImageInputDialogState createState() => ImageInputDialogState();
}

class ImageInputDialogState extends State<ImageInputDialog> {
  List<Image> get images => widget.imageList;
  late Image selectedImage = Image.asset('assets/images/sample.jpg');
  bool isImageSelected = true;

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

  void showImageDialog(Image imageWidget) {
    showDialog<void>(
      context: context,
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: InteractiveViewer(
          child: Dialog(
            child: imageWidget,
          ),
        ),
      ),
    );
  }

  final picker = ImagePicker();

  Widget content() {
    if (isImageSelected) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          itemCount: images.length + 1,
          controller: ScrollController(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: ((context, index) {
            if (index == images.length) {
              // 最後のリストであることを確認したら、別の Widget を返す
              return ListTile(
                onTap: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    final io.File pickedImage;
                    pickedImage = io.File(pickedFile.path);
                    setState(() {
                      images.add(Image.file(
                        io.File(pickedImage.path),
                        semanticLabel: pickedFile.path,
                      ));
                    });
                  }
                },
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.collections_outlined),
                    SizedBox(width: 8),
                    Text(
                      '+ ギャラリーから選ぶ',
                      style: TextStyle(color: Themes.grayColor, fontSize: 14),
                    ),
                  ],
                ),
              );
            }
            final item = Stack(
              alignment: Alignment.center,
              children: [
                RadioListTile(
                  title: Card(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: images[index].image,
                        ),
                      ),
                      height: 50,
                      width: 400,
                      child: Text(
                        images[index].semanticLabel.toString(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  value: images[index],
                  groupValue: selectedImage,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                    onPressed: () {
                      showImageDialog(images[index]);
                    },
                    shape: const CircleBorder(),
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    child: const Icon(Icons.center_focus_weak_outlined),
                  ),
                ),
              ],
            );
            return item;
          }),
        ),
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
            print(selectedImage.semanticLabel);
            Navigator.pop<String>(context, selectedImage.semanticLabel);
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
          const Divider(
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
