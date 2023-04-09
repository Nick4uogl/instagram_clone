part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent {}

class AddImages extends ImagePickerEvent {}

class DeleteImage extends ImagePickerEvent {
  DeleteImage({required this.index});
  final int index;
}

class AddMoreImages extends ImagePickerEvent {}
