import 'package:firstapp/features/feed/pages/home/addPost/AddPostPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'PostPublishPopUp.dart';
import 'PostEditImagePopUp.dart';
import 'AddPopUpHeader.dart';

class PostFilterImagePopUp extends StatelessWidget {
  const PostFilterImagePopUp({
    super.key,
    required this.images,
    required this.changePosts,
  });
  final List? images;
  final Function changePosts;

  @override
  Widget build(BuildContext context) {
    void showNextPopUp() {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => PostPublishPopUp(
          changePosts: changePosts,
          images: images,
        ),
      );
    }

    void previousPopUp() {
      Navigator.pop(context);
      if (images != null) {
        showDialog(
          context: context,
          builder: (context) => PostEditImagePopUp(
            changePosts: changePosts,
            images: images,
          ),
        );
      }
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
            SizedBox(
              width: double.infinity,
              height: 200,
              child: kIsWeb
                  ? Image.memory(images![0], fit: BoxFit.cover)
                  : Image.file(images![0], fit: BoxFit.cover),
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
