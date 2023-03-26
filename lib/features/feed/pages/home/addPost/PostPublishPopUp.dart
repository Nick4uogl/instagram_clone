import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../widgets/post.dart';
import 'PostFilterImagePopUp.dart';
import 'AddPopUpHeader.dart';

class PostPublishPopUp extends StatefulWidget {
  const PostPublishPopUp({
    super.key,
    required this.images,
    required this.changePosts,
  });
  final List? images;
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
                widget.images!.length,
                (index) => Image.memory(
                  widget.images![index],
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              )
            : List.generate(
                widget.images!.length,
                (index) => Image.file(
                  widget.images![index],
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
        images: widget.images,
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
            Expanded(
              child: kIsWeb
                  ? Image.memory(widget.images![0], fit: BoxFit.cover)
                  : Image.file(widget.images![0], fit: BoxFit.cover),
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
