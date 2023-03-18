import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timer_group/domein/models/saved_image.dart';
import 'package:timer_group/domein/provider/picked_files_provider.dart';
import 'package:timer_group/views/components/dialogs/background_input_dialog/video_imput_dialog.dart';
import 'package:timer_group/views/components/toggle_text_button.dart';
import 'package:timer_group/views/configure/theme.dart';

class ImageInputDialog extends ConsumerStatefulWidget {
  const ImageInputDialog(this.firebaseImages, this.pickedImages, {Key? key})
      : super(key: key);

  final List<Image> firebaseImages;
  final List<SavedImage> pickedImages;

  @override
  ImageInputDialogState createState() => ImageInputDialogState();
}

class ImageInputDialogState extends ConsumerState<ImageInputDialog> {
  List<Image> get images => widget.firebaseImages;

  List<SavedImage> get savedImages => widget.pickedImages;
  List<Image> pickedImages = [];
  late Image selectedImage = Image.asset('assets/images/sample.jpg');
  bool isImageSelected = true;

  @override
  initState() {
    super.initState();
    pickedImages = savedImages
        .map((i) => Image.file(
              io.File(i.url),
              semanticLabel: i.url,
            ))
        .toList();
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

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final pickedImageProvider = ref.watch(pickedFilesRepositoryProvider);

    deleteImage(String path) {
      print(path);
      final String? id =
          savedImages.where((i) => i.url == path).toList().first.id;
      if (id == null) return;
      pickedImageProvider.remove(id);
    }

    Widget content() {
      if (isImageSelected) {
        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ListTile(
                  onTap: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile == null) return;

                    final io.File pickedImage;
                    pickedImage = io.File(pickedFile.path);
                    final fileName = pickedFile.path.split('/').last;

                    final String duplicateFilePath =
                        await getApplicationDocumentsDirectory()
                            .then((value) => value.path);
                    final localImage =
                        await pickedImage.copy('$duplicateFilePath/$fileName');

                    await pickedImageProvider.addImage(
                        SavedImage(url: localImage.path, name: fileName));

                    setState(() {
                      pickedImages.insert(
                          0,
                          Image.file(
                            io.File(pickedImage.path),
                            semanticLabel: pickedImage.path,
                          ));
                    });
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
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: pickedImages.length,
                  controller: ScrollController(),
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: ((context, index) {
                    final item = Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              deleteImage(pickedImages[index].semanticLabel!);
                              pickedImages.removeAt(index);
                              setState(() {});
                            },
                            backgroundColor: Theme.of(context).cardColor,
                            foregroundColor: Colors.red,
                            icon: Icons.delete_outline,
                            label: '削除',
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          RadioListTile(
                            title: Card(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: pickedImages[index].image,
                                  ),
                                ),
                                height: 50,
                                width: 400,
                                child: Text(
                                  pickedImages[index].image.toString(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            value: pickedImages[index],
                            groupValue: selectedImage,
                            onChanged: (value) => _onRadioSelected(value),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: MaterialButton(
                              onPressed: () {
                                showImageDialog(pickedImages[index]);
                              },
                              shape: const CircleBorder(),
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.5),
                              child:
                                  const Icon(Icons.center_focus_weak_outlined),
                            ),
                          ),
                        ],
                      ),
                    );
                    return item;
                  }),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: images.length,
                  controller: ScrollController(),
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: ((context, index) {
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
              ],
            ),
          ),
        );
      } else {
        return VideoImputDialog();
      }
    }

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
