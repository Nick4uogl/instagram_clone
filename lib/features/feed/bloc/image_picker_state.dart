part of 'image_picker_bloc.dart';

abstract class ImagePickerState {
  final List<File>? pickedImages;
  final List<Uint8List>? webImages;
  const ImagePickerState({this.webImages, this.pickedImages});
}

class ImagesInitial extends ImagePickerState {
  ImagesInitial() : super(pickedImages: [], webImages: []);
}

class ImagesAdded extends ImagePickerState {
  const ImagesAdded({super.pickedImages, super.webImages});
}

class ImageDeleted extends ImagePickerState {
  const ImageDeleted({super.pickedImages, super.webImages});
}

class AddedMore extends ImagePickerState {
  const AddedMore({super.pickedImages, super.webImages});
}
