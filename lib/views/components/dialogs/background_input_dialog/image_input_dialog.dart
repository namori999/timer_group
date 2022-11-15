import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  //List<BackGroundImages> images = BackGroundImages.values;
  List<Image> get images => widget.imageList;
  late Image selectedImage = Image.asset('sample.jpg');
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
                  child: Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          showImageDialog(images[index]);
                        },
                        icon: const Icon(Icons.center_focus_weak_outlined),
                      ),
                      GestureDetector(
                        onTap: () {
                          showImageDialog(images[index]);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: images[index].image,
                              /*
                            image: AssetImage(
                                'assets/images/${images[index].name}.jpg'),
                             */
                            ),
                          ),
                          height: 50,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              images[index].semanticLabel.toString(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                value: images[index],
                groupValue: selectedImage,
                onChanged: (value) => _onRadioSelected(value),
              )),
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
            Navigator.pop<Image>(context, selectedImage);
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
