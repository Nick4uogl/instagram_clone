import 'package:firstapp/features/feed/bloc/image_picker_bloc.dart';
import 'package:firstapp/features/feed/models/pick_image_model.dart';
import 'package:firstapp/features/feed/widgets/post_edit_image_popup.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/core/data/icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_popup_header.dart';
import 'package:provider/provider.dart';

class PopUpBox extends StatelessWidget {
  const PopUpBox({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var phoneHeight =
        screenWidth < 600 ? screenHeight * 0.65 : screenHeight * 0.7;
    var phoneWidth =
        screenWidth < 750 ? screenWidth * 0.95 : screenWidth * 0.55;
    return SizedBox(
      width: phoneWidth,
      height: phoneHeight,
      child: child,
    );
  }
}

class AddPostPopUp extends StatelessWidget {
  const AddPostPopUp({
    super.key,
    this.changePosts,
  });
  final Function? changePosts;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const AddPopUpHeader(title: 'Створити допис'),
      content: PopUpBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageUpload,
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Обрати світлини",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  //await Provider.of<PickImageModel>(context, listen: false).pickImage();
                  BlocProvider.of<ImagePickerBlock>(context).add(AddImages());
                  if (context.mounted) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => PostEditImagePopUp(
                        changePosts: changePosts!,
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(13),
                  ),
                ),
                child: const Text(
                  "Вибрати з комп'ютера",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
    );
  }
}
