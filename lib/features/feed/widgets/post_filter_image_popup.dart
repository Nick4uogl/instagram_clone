import 'package:firstapp/features/feed/bloc/image_picker_bloc.dart';
import 'package:firstapp/features/feed/models/pick_image_model.dart';
import 'package:firstapp/features/feed/widgets/add_post_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'post_publish_popup.dart';
import 'post_edit_image_popup.dart';
import 'add_popup_header.dart';

class PostFilterImagePopUp extends StatelessWidget {
  const PostFilterImagePopUp({
    super.key,
    required this.changePosts,
  });
  final Function changePosts;

  @override
  Widget build(BuildContext context) {
    void showNextPopUp() {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => PostPublishPopUp(
          changePosts: changePosts,
        ),
      );
    }

    void previousPopUp() {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => PostEditImagePopUp(
          changePosts: changePosts,
          //images: images,
        ),
      );
    }

    return AlertDialog(
      title: AddPopUpHeader(
        title: 'Редагувати',
        nextButton: 'Далі',
        nextPopUp: showNextPopUp,
        previousPopUp: previousPopUp,
      ),
      content: PopUpBox(
        child: Column(
          children: [
            // Consumer<PickImageModel>(
            //   builder: (context, imageModel, child) {
            //     List? images =
            //         (kIsWeb) ? imageModel.getWebImages : imageModel.images;
            //     return SizedBox(
            //       width: double.infinity,
            //       height: 200,
            //       child: kIsWeb
            //           ? Image.memory(images![0], fit: BoxFit.cover)
            //           : Image.file(images![0], fit: BoxFit.cover),
            //     );
            //   },
            // ),
            BlocBuilder<ImagePickerBlock, ImagePickerState>(
              builder: (context, imagePickerState) {
                List? images = (kIsWeb)
                    ? imagePickerState.webImages
                    : imagePickerState.pickedImages;
                return SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: kIsWeb
                      ? Image.memory(images![0], fit: BoxFit.cover)
                      : Image.file(images![0], fit: BoxFit.cover),
                );
              },
            ),
            Row(
              children: const [
                Expanded(
                  child: TextButton(
                    onPressed: null,
                    child: Text('Фільтри'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: null,
                    child: Text('Коригування'),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[100],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[200],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[300],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[400],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[500],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[600],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
    );
  }
}
