import 'package:firstapp/features/feed/bloc/image_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'post.dart';
import 'post_filter_image_popup.dart';
import 'add_popup_header.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/features/feed/models/pick_image_model.dart';

class PostPublishPopUp extends StatefulWidget {
  const PostPublishPopUp({
    super.key,
    required this.changePosts,
  });
  final Function changePosts;

  @override
  State<PostPublishPopUp> createState() => _PostPublishPopUpState();
}

class _PostPublishPopUpState extends State<PostPublishPopUp> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void publishPopUp() {
    // List? images = (kIsWeb)
    //     ? Provider.of<PickImageModel>(context, listen: false).webImages
    //     : Provider.of<PickImageModel>(context, listen: false).images;
    List? images = [];
    BlocListener<ImagePickerBlock, ImagePickerState>(
      listener: (context, state) {
        images = (kIsWeb) ? state.webImages : state.pickedImages;
      },
    );

    widget.changePosts(
      Post(
        id: '4',
        authorName: 'nicky_p',
        location: 'Volyn, Berestiane',
        isOriginalProfile: true,
        authorAvatarPath: 'images/avatar.jpg',
        description: myController.text,
        imageList: kIsWeb
            ? List.generate(
                images!.length,
                (index) => Image.memory(
                  images![index],
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              )
            : List.generate(
                images!.length,
                (index) => Image.file(
                  images![index],
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
      ),
    );
    Navigator.pop(context);
  }

  void showPreviousPopUp() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => PostFilterImagePopUp(
        changePosts: widget.changePosts,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AddPopUpHeader(
        nextPopUp: publishPopUp,
        nextButton: 'Поширити',
        previousPopUp: showPreviousPopUp,
      ),
      content: SizedBox(
        width: 320,
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Consumer<PickImageModel>(
            //   builder: (context, imageModel, child) {
            //     List? images =
            //         (kIsWeb) ? imageModel.getWebImages : imageModel.images;
            //     return Expanded(
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
                return Expanded(
                  child: kIsWeb
                      ? Image.memory(images![0], fit: BoxFit.cover)
                      : Image.file(images![0], fit: BoxFit.cover),
                );
              },
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: myController,
                    decoration: const InputDecoration(
                      labelText: 'Додайте опис',
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
    );
  }
}
