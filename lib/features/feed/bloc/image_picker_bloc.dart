import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBlock extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBlock() : super(ImagesInitial()) {
    on<AddImages>(_onAddImages);
  }

  Future<List<Uint8List>> getImages(List<XFile> list) async {
    final List<Uint8List> images = [];
    for (var i = 0; i < list.length; i++) {
      var f = await list[i].readAsBytes();
      images.add(f);
    }
    return images;
  }

  Future<void> _onAddImages(
      ImagePickerEvent event, Emitter<ImagePickerState> emit) async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile?>? imageList = await picker.pickMultiImage();
      var selectedList = List.generate(
          imageList.length, (index) => File(imageList[index]!.path));
      emit(ImagesAdded(webImages: [], pickedImages: selectedList));
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile>? imageList = await picker.pickMultiImage();
      var selectedList = await getImages(imageList);
      emit(ImagesAdded(webImages: selectedList, pickedImages: []));
    } else {
      return;
    }
  }
}
