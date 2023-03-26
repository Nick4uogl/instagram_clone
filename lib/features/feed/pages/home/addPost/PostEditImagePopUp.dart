import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'AddPostPopUp.dart';
import 'PostFilterImagePopUp.dart';
import 'AddPopUpHeader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firstapp/core/data/icons.dart';

class PostEditImagePopUp extends StatefulWidget {
  const PostEditImagePopUp({
    super.key,
    required this.images,
    required this.changePosts,
  });
  final List? images;
  final Function changePosts;

  @override
  State<PostEditImagePopUp> createState() => _PostEditImagePopUpState();
}

class _PostEditImagePopUpState extends State<PostEditImagePopUp>
    with TickerProviderStateMixin {
  double zoomValue = 0;
  int currentActive = -1;
  late List<Widget> imageList;
  CarouselController controller1 = CarouselController();
  CarouselController controller2 = CarouselController();
  int currentImage = 0;

  void changeCurrent(int value) {
    setState(() {
      currentImage = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void changeZoomValue(value) {
    setState(() {
      zoomValue = value;
    });
  }

  void showNextPopUp() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => PostFilterImagePopUp(
        images: widget.images,
        changePosts: widget.changePosts,
      ),
    );
  }

  void showPreviousPopUp() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AddPostPopUp(
        changePosts: widget.changePosts,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var phoneHeight =
        screenWidth < 600 ? screenHeight * 0.65 : screenHeight * 0.7;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentActive = -1;
        });
      },
      child: AlertDialog(
        title: AddPopUpHeader(
          nextPopUp: showNextPopUp,
          previousPopUp: showPreviousPopUp,
          title: 'Обітнути',
          nextButton: 'Далі',
        ),
        content: PopUpBox(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CarouselSlider(
                        items: List.generate(widget.images!.length, (index) {
                          return kIsWeb
                              ? Image.memory(
                                  widget.images![index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Image.file(
                                  widget.images![index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                );
                        }),
                        options: CarouselOptions(
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            height: double.infinity,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentImage = index;
                              });
                              controller2.animateToPage(currentImage);
                            }),
                        carouselController: controller1,
                      ),
                    ),
                    if (currentImage < widget.images!.length - 1 ||
                        currentImage == 1)
                      Positioned(
                        top: phoneHeight * 0.5 - 20,
                        right: 15,
                        child: ElevatedButton(
                          onPressed: () {
                            controller1.animateToPage(currentImage + 1);
                            controller2.animateToPage(currentImage + 1);
                            setState(() {
                              currentImage += 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            fixedSize: const Size(40, 40),
                            padding: EdgeInsets.zero,
                            backgroundColor: (currentActive == 0)
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black.withOpacity(0.5),
                          ),
                          child: arrowRight,
                        ),
                      ),
                    if (currentImage > 0)
                      Positioned(
                        top: phoneHeight * 0.5 - 20,
                        left: 15,
                        child: ElevatedButton(
                          onPressed: () {
                            controller1.animateToPage(currentImage - 1);
                            controller2.animateToPage(currentImage - 1);
                            setState(() {
                              currentImage -= 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            fixedSize: const Size(40, 40),
                            padding: EdgeInsets.zero,
                            backgroundColor: (currentActive == 0)
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black.withOpacity(0.5),
                          ),
                          child: arrowLeft,
                        ),
                      )
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (currentActive == 0) {
                              currentActive = -1;
                            } else {
                              currentActive = 0;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          fixedSize: const Size(40, 40),
                          padding: EdgeInsets.zero,
                          backgroundColor: (currentActive == 0)
                              ? Colors.white.withOpacity(0.8)
                              : Colors.black.withOpacity(0.5),
                        ),
                        child: (currentActive == 0)
                            ? SvgPicture.asset(
                                'images/resize.svg',
                                width: 16,
                                height: 16,
                                color: Colors.black,
                              )
                            : SvgPicture.asset(
                                'images/resize.svg',
                                width: 16,
                                height: 16,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (currentActive == 1) {
                              currentActive = -1;
                            } else {
                              currentActive = 1;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          fixedSize: const Size(40, 40),
                          padding: EdgeInsets.zero,
                          backgroundColor: (currentActive == 1)
                              ? Colors.white.withOpacity(0.8)
                              : Colors.black.withOpacity(0.5),
                        ),
                        child: Icon(
                          Icons.zoom_in,
                          color: (currentActive == 1)
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (currentActive == 2) {
                              currentActive = -1;
                            } else {
                              currentActive = 2;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          fixedSize: const Size(40, 40),
                          padding: EdgeInsets.zero,
                          backgroundColor: (currentActive == 2)
                              ? Colors.white.withOpacity(0.8)
                              : Colors.black.withOpacity(0.5),
                        ),
                        child: (currentActive == 2)
                            ? SvgPicture.asset(
                                'images/showAll.svg',
                                color: Colors.black,
                              )
                            : SvgPicture.asset(
                                'images/showAll.svg',
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              ZoomSlider(
                zoomValue: zoomValue,
                changeZoomValue: changeZoomValue,
                currentActive: currentActive,
              ),
              ImageRatio(
                currentActive: currentActive,
              ),
              AddMore(
                currentActive: currentActive,
                images: widget.images,
                controller1: controller1,
                controller2: controller2,
                currentImage: currentImage,
                changeImage: changeCurrent,
              )
            ],
          ),
        ),
        contentPadding: const EdgeInsets.all(0),
        titlePadding: const EdgeInsets.all(0),
      ),
    );
  }
}

class ZoomSlider extends StatelessWidget {
  const ZoomSlider(
      {super.key,
      required this.currentActive,
      required this.zoomValue,
      required this.changeZoomValue});
  final int currentActive;
  final double zoomValue;
  final Function changeZoomValue;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 45,
      left: 60,
      child: AnimatedContainer(
        margin: EdgeInsets.only(bottom: (currentActive == 1) ? 15 : 0),
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          opacity: (currentActive == 1) ? 1 : 0,
          duration: const Duration(milliseconds: 400),
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
                onChanged: (double value) {
                  changeZoomValue(value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageRatio extends StatefulWidget {
  const ImageRatio({
    super.key,
    required this.currentActive,
  });
  final int currentActive;

  @override
  State<ImageRatio> createState() => _ImageRatioState();
}

class _ImageRatioState extends State<ImageRatio> {
  int currentActive = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 45,
      left: 15,
      child: AnimatedContainer(
        margin: EdgeInsets.only(bottom: (widget.currentActive == 0) ? 15 : 0),
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          opacity: (widget.currentActive == 0) ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          child: Container(
              width: 128,
              //height: 195,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentActive = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Оригінал',
                            style: (currentActive == 0)
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 15),
                          (currentActive == 0)
                              ? SvgPicture.asset('images/image.svg',
                                  color: Colors.white)
                              : SvgPicture.asset('images/image.svg',
                                  color: Color(0xffa7a49f))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentActive = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '1:1',
                            style: (currentActive == 1)
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 15),
                          (currentActive == 1)
                              ? SvgPicture.asset('images/rect1.svg',
                                  color: Colors.white)
                              : SvgPicture.asset('images/rect1.svg')
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentActive = 2;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '4:5',
                            style: (currentActive == 2)
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 15),
                          (currentActive == 2)
                              ? SvgPicture.asset('images/rect2.svg',
                                  color: Colors.white)
                              : SvgPicture.asset('images/rect2.svg')
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentActive = 3;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      child: Row(
                        children: [
                          Text(
                            '16:9',
                            style: (currentActive == 3)
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 15),
                          (currentActive == 3)
                              ? SvgPicture.asset('images/rect3.svg',
                                  color: Colors.white)
                              : SvgPicture.asset('images/rect3.svg')
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class AddMore extends StatefulWidget {
  const AddMore({
    super.key,
    required this.currentActive,
    required this.images,
    required this.controller1,
    required this.controller2,
    required this.currentImage,
    required this.changeImage,
  });
  final int currentActive;
  final List? images;
  final CarouselController controller1;
  final CarouselController controller2;
  final int currentImage;
  final Function changeImage;

  @override
  State<AddMore> createState() => _AddMoreState();
}

class _AddMoreState extends State<AddMore> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 45,
      right: 15,
      child: AnimatedContainer(
        margin: EdgeInsets.only(bottom: (widget.currentActive == 2) ? 15 : 0),
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          opacity: (widget.currentActive == 2) ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          child: Container(
              height: 120,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    height: 100,
                    child: Stack(
                      children: [
                        CarouselSlider(
                          items: List.generate(widget.images!.length, (index) {
                            return Stack(
                              children: [
                                kIsWeb
                                    ? Image.memory(
                                        widget.images![index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      )
                                    : Image.file(
                                        widget.images![index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      fixedSize: const Size(25, 25),
                                      padding: EdgeInsets.zero,
                                      backgroundColor:
                                          Colors.black.withOpacity(0.5),
                                    ),
                                    child: SvgPicture.asset(
                                      'images/delete.svg',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  widget.changeImage(index);
                                });
                                widget.controller1
                                    .animateToPage(widget.currentImage);
                              }),
                          carouselController: widget.controller2,
                        ),
                        if (widget.currentImage < widget.images!.length - 1 ||
                            widget.currentImage == 1)
                          Positioned(
                            top: 40,
                            right: 5,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.controller1
                                    .animateToPage(widget.currentImage + 1);
                                widget.controller2
                                    .animateToPage(widget.currentImage + 1);
                                widget.changeImage(widget.currentImage + 1);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                fixedSize: const Size(20, 20),
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.black.withOpacity(0.5),
                              ),
                              child: arrowRight,
                            ),
                          ),
                        if (widget.currentImage > 0)
                          Positioned(
                            top: 40,
                            left: 5,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.controller1
                                    .animateToPage(widget.currentImage - 1);
                                widget.controller2
                                    .animateToPage(widget.currentImage - 1);
                                widget.changeImage(widget.currentImage - 1);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                fixedSize: const Size(20, 20),
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.black.withOpacity(0.5),
                              ),
                              child: arrowLeft,
                            ),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 50),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        fixedSize:
                            MaterialStateProperty.all<Size>(const Size(50, 50)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black.withOpacity(0.6),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset('images/plus.svg'),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
