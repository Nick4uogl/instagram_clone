part of 'image_picker_bloc.dart';

abstract class ImagePickerState {
  final List<File>? pickedImages;
  final List<Uint8List>? webImages;
  const ImagePickerState({required this.webImages, required this.pickedImages});
}

class ImagesInitial extends ImagePickerState {
  ImagesInitial() : super(pickedImages: [], webImages: []);
}

class ImagesAdded extends ImagePickerState {
  final List<File>? pickedImages;
  final List<Uint8List>? webImages;

  const ImagesAdded({required this.webImages, required this.pickedImages})
      : super(pickedImages: pickedImages, webImages: webImages);
}
