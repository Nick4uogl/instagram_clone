import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PickImageModel extends ChangeNotifier {
  List<File>? pickedImages;
  List<Uint8List>? webImages;

  Future<List<Uint8List>> getImages(List<XFile> list) async {
    final List<Uint8List> images = [];
    for (var i = 0; i < list.length; i++) {
      var f = await list[i].readAsBytes();
      images.add(f);
    }
    return images;
  }

  Future<void> pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile?>? imageList = await picker.pickMultiImage();
      var selectedList = List.generate(
          imageList.length, (index) => File(imageList[index]!.path));
      pickedImages = selectedList;
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile>? imageList = await picker.pickMultiImage();
      var selectedList = await getImages(imageList);
      webImages = selectedList;
    } else {
      return;
    }
  }

  List<File>? get images => pickedImages;
  List<Uint8List>? get getWebImages => webImages;
}
