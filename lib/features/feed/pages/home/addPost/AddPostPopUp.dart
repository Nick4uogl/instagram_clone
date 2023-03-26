import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firstapp/core/data/icons.dart';
import 'package:flutter/foundation.dart';
import 'PostEditImagePopUp.dart';
import 'AddPopUpHeader.dart';

class PopUpBox extends StatelessWidget {
  const PopUpBox({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var phoneHeight =
        screenWidth < 600 ? screenHeight * 0.65 : screenHeight * 0.7;
    var phoneWidth =
        screenWidth < 750 ? screenWidth * 0.95 : screenWidth * 0.55;
    return SizedBox(
      width: phoneWidth,
      height: phoneHeight,
      child: child,
    );
  }
}

class AddPostPopUp extends StatefulWidget {
  const AddPostPopUp({
    super.key,
    this.changePosts,
  });
  final Function? changePosts;

  @override
  State<AddPostPopUp> createState() => _AddPostPopUpState();
}

class _AddPostPopUpState extends State<AddPostPopUp> {
  List<File>? _pickedImages;
  List<Uint8List>? webImages;
  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile?>? imageList = await picker.pickMultiImage();
      if (imageList[0] != null) {
        var selectedList = List.generate(
            imageList.length, (index) => File(imageList[index]!.path));
        setState(() {
          _pickedImages = selectedList;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      Future<List<Uint8List>> getImages(List<XFile> list) async {
        final List<Uint8List> images = [];
        for (var i = 0; i < list.length; i++) {
          var f = await list[i].readAsBytes();
          images.add(f);
        }
        return images;
      }

      final ImagePicker picker = ImagePicker();
      List<XFile>? imageList = await picker.pickMultiImage();

      var selectedList = await getImages(imageList);
      setState(() {
        webImages = selectedList;
      });
    } else {
      print("Something went wrong");
    }
  }

  void deleteImage(int index) {
    setState(() {
      if (kIsWeb) {
        webImages!.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const AddPopUpHeader(title: 'Створити допис'),
      content: PopUpBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageUpload,
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Обрати світлини",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _pickImage();
                  if (context.mounted) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => PostEditImagePopUp(
                        images: kIsWeb ? webImages : _pickedImages,
                        changePosts: widget.changePosts!,
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(13),
                  ),
                ),
                child: const Text(
                  "Вибрати з комп'ютера",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
    );
  }
}
