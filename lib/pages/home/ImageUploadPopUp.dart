import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firstapp/data/icons.dart';
import 'package:flutter/foundation.dart';
import '../../widgets/post.dart';

class ImageUploadPopUp extends StatefulWidget {
  const ImageUploadPopUp({super.key, required this.changePosts});
  final Function changePosts;

  @override
  State<ImageUploadPopUp> createState() => _ImageUploadPopUpState();
}

class _ImageUploadPopUpState extends State<ImageUploadPopUp> {
  List<File>? _pickedImages;
  int currentPopUp = 0;
  List<Uint8List>? webImages;

  void decreaseCurrent(int value) {
    setState(() {
      currentPopUp -= value;
    });
  }

  void changeCurrent(int value) {
    setState(() {
      currentPopUp = value;
    });
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      List<XFile?>? imageList = await picker.pickMultiImage();
      if (imageList[0] != null) {
        var selectedList = List.generate(
            imageList.length, (index) => File(imageList[index]!.path));
        setState(() {
          _pickedImages = selectedList;
          currentPopUp = 1;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      Future<List<Uint8List>> getImages(List<XFile> list) async {
        final List<Uint8List> images = [];
        for (var i = 0; i < list.length; i++) {
          var f = await list[i].readAsBytes();
          images.add(f);
        }
        return images;
      }

      final ImagePicker picker = ImagePicker();
      List<XFile>? imageList = await picker.pickMultiImage();

      var selectedList = await getImages(imageList);
      setState(() {
        webImages = selectedList;
        currentPopUp = 1;
      });
    } else {
      print("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var phoneHeight =
        screenWidth < 600 ? screenHeight * 0.55 : screenHeight * 0.7;
    var phoneWidth =
        screenWidth < 750 ? screenWidth * 0.85 : screenWidth * 0.55;
    return currentPopUp == 0
        ? ImageUploadFirstRoute(
            pickImage: _pickImage,
            phoneHeight: phoneHeight,
            phoneWidth: phoneWidth,
          )
        : currentPopUp == 1
            ? ImageUploadSecondRoute(
                phoneWidth: phoneWidth,
                phoneHeight: phoneHeight,
                changeCurrent: changeCurrent,
                decreaseCurrent: decreaseCurrent,
                webImages: webImages,
                pickedImages: _pickedImages)
            : currentPopUp == 2
                ? ImageUploadThirdRoute(
                    changeCurrent: changeCurrent,
                    decreaseCurrent: decreaseCurrent,
                    webImages: webImages,
                    pickedImages: _pickedImages,
                  )
                : ImageUploadFourthRoute(
                    decreaseCurrent: decreaseCurrent,
                    webImages: webImages,
                    pickedImages: _pickedImages,
                    changePosts: widget.changePosts,
                  );
  }
}

class ImageUploadFirstRoute extends StatelessWidget {
  const ImageUploadFirstRoute(
      {super.key,
      required this.pickImage,
      required this.phoneWidth,
      required this.phoneHeight});
  final Function pickImage;
  final double phoneWidth;
  final double phoneHeight;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        child: const Center(child: Text('Створити допис')),
      ),
      content: SizedBox(
        width: phoneWidth,
        height: phoneHeight,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.upload_file),
              const SizedBox(
                height: 20,
              ),
              const Text("Обрати світлини"),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await pickImage();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  "Вибрати з комп'ютера",
                  style: TextStyle(color: Colors.white),
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

class ImageUploadSecondRoute extends StatefulWidget {
  const ImageUploadSecondRoute(
      {super.key,
      required this.phoneWidth,
      required this.phoneHeight,
      required this.changeCurrent,
      required this.decreaseCurrent,
      this.webImages,
      this.pickedImages});
  final double phoneWidth;
  final double phoneHeight;
  final Function decreaseCurrent;
  final Function changeCurrent;
  final List<Uint8List>? webImages;
  final List? pickedImages;

  @override
  State<ImageUploadSecondRoute> createState() => _ImageUploadSecondRouteState();
}

class _ImageUploadSecondRouteState extends State<ImageUploadSecondRoute> {
  double zoomValue = 0;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  widget.decreaseCurrent(1);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            const Text(
              'Обітнути',
              style: TextStyle(color: Colors.black),
            ),
            TextButton(
              onPressed: () {
                widget.changeCurrent(2);
              },
              child: const Text(
                'Далі',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      content: Stack(
        children: [
          Container(
            width: widget.phoneWidth,
            height: widget.phoneHeight,
            color: Colors.white,
            child: kIsWeb
                ? Image.memory(widget.webImages![0], fit: BoxFit.cover)
                : Image.file(widget.pickedImages![0], fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: SizedBox(
              width: widget.phoneWidth - 20,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        visible = !visible;
                      })
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      fixedSize: const Size(40, 40),
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: resize,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        visible = !visible;
                      })
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      fixedSize: const Size(40, 40),
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: const Icon(
                      Icons.zoom_in,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        visible = !visible;
                      })
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      fixedSize: const Size(40, 40),
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: showAll,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 10,
            child: AnimatedOpacity(
              opacity: visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: 140,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15)),
                child: SliderTheme(
                  data: const SliderThemeData(
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 2,
                  ),
                  child: Slider(
                      value: zoomValue,
                      max: 1,
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      activeColor: Colors.white,
                      inactiveColor: Colors.black,
                      onChanged: null),
                ),
              ),
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
    );
  }
}

class ImageUploadThirdRoute extends StatelessWidget {
  const ImageUploadThirdRoute(
      {super.key,
      required this.changeCurrent,
      required this.decreaseCurrent,
      this.webImages,
      this.pickedImages});
  final Function decreaseCurrent;
  final Function changeCurrent;
  final List<Uint8List>? webImages;
  final List? pickedImages;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  decreaseCurrent(1);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            const Text(
              'Редагувати',
              style: TextStyle(color: Colors.black),
            ),
            TextButton(
              onPressed: () {
                changeCurrent(3);
              },
              child: const Text(
                'Далі',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      content: SizedBox(
        width: 320,
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: kIsWeb
                  ? Image.memory(webImages![0], fit: BoxFit.cover)
                  : Image.file(pickedImages![0], fit: BoxFit.cover),
            ),
            Expanded(
                child: Column(
              children: [
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
                  height: 100,
                  child: ListView(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
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

class ImageUploadFourthRoute extends StatefulWidget {
  const ImageUploadFourthRoute({
    super.key,
    required this.decreaseCurrent,
    this.webImages,
    this.pickedImages,
    required this.changePosts,
  });
  final Function decreaseCurrent;
  final List<Uint8List>? webImages;
  final List? pickedImages;
  final Function changePosts;

  @override
  State<ImageUploadFourthRoute> createState() => _ImageUploadFourthRouteState();
}

class _ImageUploadFourthRouteState extends State<ImageUploadFourthRoute> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  widget.decreaseCurrent(1);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            TextButton(
              onPressed: () {
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
                            widget.webImages!.length,
                            (index) => Image.memory(
                              widget.webImages![index],
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          )
                        : List.generate(
                            widget.webImages!.length,
                            (index) => Image.file(
                              widget.pickedImages![index],
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text(
                'Поширити',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      content: SizedBox(
        width: 320,
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: kIsWeb
                  ? Image.memory(widget.webImages![0], fit: BoxFit.cover)
                  : Image.file(widget.pickedImages![0], fit: BoxFit.cover),
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
