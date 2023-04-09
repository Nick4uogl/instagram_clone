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
    on<DeleteImage>(_onDeleteImage);
    on<AddMoreImages>(_onAddMore);
  }

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

  Future<void> _onAddImages(
      ImagePickerEvent event, Emitter<ImagePickerState> emit) async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile?>? imageList = await picker.pickMultiImage();
      var selectedList = List.generate(
          imageList.length, (index) => File(imageList[index]!.path));
      pickedImages = selectedList;
      emit(ImagesAdded(webImages: [], pickedImages: selectedList));
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile>? imageList = await picker.pickMultiImage();
      var selectedList = await getImages(imageList);
      webImages = selectedList;
      emit(ImagesAdded(webImages: selectedList, pickedImages: []));
    } else {
      return;
    }
  }

  Future<void> _onAddMore(
      ImagePickerEvent event, Emitter<ImagePickerState> emit) async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile?>? imageList = await picker.pickMultiImage();
      var selectedList = List.generate(
          imageList.length, (index) => File(imageList[index]!.path));
      pickedImages = [...pickedImages!, ...selectedList];
      emit(AddedMore(webImages: [], pickedImages: selectedList));
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile>? imageList = await picker.pickMultiImage();
      var selectedList = await getImages(imageList);
      webImages = [...webImages!, ...selectedList];
      emit(ImagesAdded(webImages: webImages, pickedImages: []));
    } else {
      return;
    }
  }

  void _onDeleteImage(DeleteImage event, Emitter<ImagePickerState> emit) {
    if (kIsWeb) {
      webImages?.removeAt(event.index);
    } else {
      pickedImages?.removeAt(event.index);
    }
    emit(ImageDeleted(webImages: webImages, pickedImages: pickedImages));
  }
}
