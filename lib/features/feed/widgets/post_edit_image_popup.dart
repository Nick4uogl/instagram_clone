import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firstapp/features/feed/bloc/image_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_post_popup.dart';
import 'post_filter_image_popup.dart';
import 'add_popup_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firstapp/core/data/icons.dart';

class CustomFadeAnimation extends StatefulWidget {
  const CustomFadeAnimation(
      {super.key,
      required this.child,
      required this.currentActive,
      required this.active});
  final Widget child;
  final int currentActive;
  final int active;

  @override
  State<CustomFadeAnimation> createState() => _CustomFadeAnimationState();
}

class _CustomFadeAnimationState extends State<CustomFadeAnimation> {
  bool isCompleted = true;
  late Timer _timer;

  bool delayHide() {
    if (isCompleted) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(
          bottom: (widget.currentActive == widget.active) ? 15 : 0),
      duration: const Duration(milliseconds: 400),
      child: AnimatedOpacity(
        opacity: (widget.currentActive == widget.active) ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        onEnd: () {
          setState(() {
            isCompleted = !isCompleted;
          });
        },
        child: Visibility(
          visible: (widget.currentActive == widget.active) ? true : delayHide(),
          child: widget.child,
        ),
      ),
    );
  }
}

class PostEditImagePopUp extends StatefulWidget {
  const PostEditImagePopUp({
    super.key,
    required this.changePosts,
  });
  final Function changePosts;

  @override
  State<PostEditImagePopUp> createState() => _PostEditImagePopUpState();
}

class _PostEditImagePopUpState extends State<PostEditImagePopUp>
    with TickerProviderStateMixin {
  int currentActive = -1;

  void changeCurrentActive(value) {
    setState(() {
      currentActive = value;
    });
  }

  void showNextPopUp() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => PostFilterImagePopUp(
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
          child: PostEditImagePopUpBody(
            changePosts: widget.changePosts,
            currentActive: currentActive,
            changeCurrentActive: changeCurrentActive,
            showPreviousPopUp: showPreviousPopUp,
          ),
        ),
        contentPadding: const EdgeInsets.all(0),
        titlePadding: const EdgeInsets.all(0),
      ),
    );
  }
}

class PostEditImagePopUpBody extends StatefulWidget {
  const PostEditImagePopUpBody(
      {super.key,
      required this.changePosts,
      required this.currentActive,
      required this.changeCurrentActive,
      required this.showPreviousPopUp});
  final Function changePosts;
  final int currentActive;
  final Function changeCurrentActive;
  final Function showPreviousPopUp;

  @override
  State<PostEditImagePopUpBody> createState() => _PostEditImagePopUpBodyState();
}

class _PostEditImagePopUpBodyState extends State<PostEditImagePopUpBody> {
  CarouselController controller1 = CarouselController();
  CarouselController controller2 = CarouselController();
  double zoomValue = 0;
  int currentImage = 0;

  void changeCurrent(int value) {
    controller1.animateToPage(currentImage + value);
    controller2.animateToPage(currentImage + value);
    setState(() {
      currentImage += value;
    });
  }

  void changeCurrentImage(int value) {
    setState(() {
      currentImage = value;
    });
  }

  void changeZoomValue(value) {
    setState(() {
      zoomValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var phoneHeight =
        screenWidth < 600 ? screenHeight * 0.65 : screenHeight * 0.7;
    return BlocBuilder<ImagePickerBlock, ImagePickerState>(
      buildWhen: (previous, current) {
        return (current.webImages != null);
      },
      builder: (_, imagePickerState) {
        List? images = (kIsWeb)
            ? imagePickerState.webImages
            : imagePickerState.pickedImages;
        var imagesList = List.generate(
          images!.length,
          (index) {
            return kIsWeb
                ? Image.memory(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Image.file(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
          },
        );
        return Stack(
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
                      items: imagesList,
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
                  if (currentImage < images.length - 1 || currentImage == 1)
                    CarouselArrow(
                      changeCurrent: () {
                        controller1.animateToPage(currentImage + 1);
                        controller2.animateToPage(currentImage + 1);
                        setState(() {
                          currentImage += 1;
                        });
                      },
                      icon: arrowRight,
                      size: 40,
                      top: phoneHeight * 0.5 - 20,
                      right: 15,
                    ),
                  if (currentImage > 0)
                    CarouselArrow(
                      changeCurrent: () {
                        controller1.animateToPage(currentImage - 1);
                        controller2.animateToPage(currentImage - 1);
                        setState(() {
                          currentImage -= 1;
                        });
                      },
                      icon: arrowLeft,
                      size: 40,
                      top: phoneHeight * 0.5 - 20,
                      left: 15,
                    ),
                ],
              ),
            ),
            PostEditImageButtons(
              currentActive: widget.currentActive,
              changeCurrentActive: widget.changeCurrentActive,
            ),
            ZoomSlider(
              zoomValue: zoomValue,
              changeZoomValue: changeZoomValue,
              currentActive: widget.currentActive,
            ),
            ImageRatio(
              currentActive: widget.currentActive,
            ),
            AddMore(
              currentActive: widget.currentActive,
              controller1: controller1,
              controller2: controller2,
              currentImage: currentImage,
              changeImage: changeCurrentImage,
              showPreviousPopUp: widget.showPreviousPopUp,
            )
          ],
        );
      },
    );
  }
}

class PostEditImageButtons extends StatelessWidget {
  const PostEditImageButtons(
      {super.key,
      required this.currentActive,
      required this.changeCurrentActive});
  final int currentActive;
  final Function changeCurrentActive;

  void changeActiveRationBtn() {
    if (currentActive == 0) {
      changeCurrentActive(-1);
    } else {
      changeCurrentActive(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        children: [
          const SizedBox(width: 10),
          PostEditImageBtn(
            changeCurrentActive: () {
              if (currentActive == 0) {
                changeCurrentActive(-1);
              } else {
                changeCurrentActive(0);
              }
            },
            currentActive: currentActive,
            active: 0,
            icon: (currentActive == 0)
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
          const SizedBox(
            width: 10,
          ),
          PostEditImageBtn(
            changeCurrentActive: () {
              if (currentActive == 1) {
                changeCurrentActive(-1);
              } else {
                changeCurrentActive(1);
              }
            },
            currentActive: currentActive,
            active: 1,
            icon: Icon(
              Icons.zoom_in,
              color: (currentActive == 1) ? Colors.black : Colors.white,
            ),
          ),
          const Spacer(),
          PostEditImageBtn(
            changeCurrentActive: () {
              if (currentActive == 2) {
                changeCurrentActive(-1);
              } else {
                changeCurrentActive(2);
              }
            },
            currentActive: currentActive,
            active: 2,
            icon: (currentActive == 2)
                ? SvgPicture.asset(
                    'images/showAll.svg',
                    color: Colors.black,
                  )
                : SvgPicture.asset(
                    'images/showAll.svg',
                  ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

class PostEditImageBtn extends StatelessWidget {
  const PostEditImageBtn({
    super.key,
    required this.changeCurrentActive,
    required this.currentActive,
    required this.active,
    required this.icon,
  });
  final Function changeCurrentActive;
  final int currentActive;
  final int active;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: Colors.black12,
          splashColor: Colors.grey,
          onTap: () {
            changeCurrentActive();
          },
          child: Ink(
            color: (currentActive == active)
                ? Colors.white.withOpacity(0.8)
                : Colors.black.withOpacity(0.5),
            width: 40,
            height: 40,
            child: Center(
              child: icon,
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

  void changeCurrentActive(int value) {
    setState(() {
      currentActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 45,
      left: 15,
      child: CustomFadeAnimation(
        currentActive: widget.currentActive,
        active: 0,
        child: Container(
          width: 128,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              ImageRatioBtn(
                changeCurrentActive: () {
                  setState(() {
                    currentActive = 0;
                  });
                },
                borderSideEnabled: true,
                currentActive: currentActive,
                active: 0,
                text: 'Оригінал',
                icon: (currentActive == 0)
                    ? SvgPicture.asset(
                        'images/image.svg',
                        color: Colors.white,
                      )
                    : SvgPicture.asset(
                        'images/image.svg',
                        color: const Color(0xffa7a49f),
                      ),
              ),
              ImageRatioBtn(
                changeCurrentActive: () {
                  setState(() {
                    currentActive = 1;
                  });
                },
                borderSideEnabled: true,
                currentActive: currentActive,
                active: 1,
                text: '1:1',
                icon: (currentActive == 1)
                    ? SvgPicture.asset(
                        'images/rect1.svg',
                        color: Colors.white,
                      )
                    : SvgPicture.asset(
                        'images/rect1.svg',
                      ),
              ),
              ImageRatioBtn(
                  changeCurrentActive: () {
                    setState(() {
                      currentActive = 2;
                    });
                  },
                  borderSideEnabled: true,
                  currentActive: currentActive,
                  active: 2,
                  text: '4:5',
                  icon: (currentActive == 2)
                      ? SvgPicture.asset(
                          'images/rect2.svg',
                          color: Colors.white,
                        )
                      : SvgPicture.asset(
                          'images/rect2.svg',
                        )),
              ImageRatioBtn(
                changeCurrentActive: () {
                  setState(() {
                    currentActive = 3;
                  });
                },
                borderSideEnabled: false,
                currentActive: currentActive,
                active: 3,
                text: '9:16',
                icon: (currentActive == 3)
                    ? SvgPicture.asset('images/rect3.svg', color: Colors.white)
                    : SvgPicture.asset(
                        'images/rect3.svg',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageRatioBtn extends StatelessWidget {
  const ImageRatioBtn({
    super.key,
    required this.changeCurrentActive,
    required this.borderSideEnabled,
    required this.currentActive,
    required this.active,
    required this.icon,
    required this.text,
  });
  final Function changeCurrentActive;
  final int currentActive;
  final int active;
  final bool borderSideEnabled;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeCurrentActive();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: (borderSideEnabled)
                ? const BorderSide(width: 1, color: Colors.grey)
                : const BorderSide(width: 0, color: Colors.transparent),
          ),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: (currentActive == active)
                  ? const TextStyle(color: Colors.white)
                  : const TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 15),
            icon,
          ],
        ),
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
      child: CustomFadeAnimation(
        currentActive: currentActive,
        active: 1,
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
    );
  }
}

class AddMore extends StatefulWidget {
  const AddMore({
    super.key,
    required this.currentActive,
    required this.controller1,
    required this.controller2,
    required this.currentImage,
    required this.changeImage,
    required this.showPreviousPopUp,
  });
  final int currentActive;
  final CarouselController controller1;
  final CarouselController controller2;
  final int currentImage;
  final Function changeImage;
  final Function showPreviousPopUp;

  @override
  State<AddMore> createState() => _AddMoreState();
}

class _AddMoreState extends State<AddMore> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 45,
      right: 15,
      child: CustomFadeAnimation(
        currentActive: widget.currentActive,
        active: 2,
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
                height: double.infinity,
                child: BlocBuilder<ImagePickerBlock, ImagePickerState>(
                  buildWhen: (previous, current) {
                    return (current.webImages != null);
                  },
                  builder: (context, imagePickerState) {
                    List? images = (kIsWeb)
                        ? imagePickerState.webImages
                        : imagePickerState.pickedImages;
                    var imagesList = List.generate(images!.length, (index) {
                      return Stack(
                        children: [
                          kIsWeb
                              ? Image.memory(
                                  images[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Image.file(
                                  images[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                          AddMoreDeleteBtn(
                              currentImage: widget.currentImage,
                              showPreviousPopUp: widget.showPreviousPopUp)
                        ],
                      );
                    });
                    return Stack(
                      children: [
                        CarouselSlider(
                          items: imagesList,
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  widget.changeImage(index);
                                });
                                widget.controller1.animateToPage(index);
                              }),
                          carouselController: widget.controller2,
                        ),
                        if (widget.currentImage < images.length - 1 ||
                            widget.currentImage == 1)
                          CarouselArrow(
                            changeCurrent: () {
                              widget.controller1
                                  .animateToPage(widget.currentImage + 1);
                              widget.controller2
                                  .animateToPage(widget.currentImage + 1);
                              widget.changeImage(widget.currentImage + 1);
                            },
                            icon: arrowRight,
                            size: 20,
                            top: 40,
                            right: 5,
                          ),
                        if (widget.currentImage > 0)
                          CarouselArrow(
                            changeCurrent: () {
                              widget.controller1
                                  .animateToPage(widget.currentImage - 1);
                              widget.controller2
                                  .animateToPage(widget.currentImage - 1);
                              widget.changeImage(widget.currentImage - 1);
                            },
                            icon: arrowLeft,
                            size: 20,
                            top: 40,
                            left: 5,
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              const AddMoreBtn(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddMoreBtn extends StatelessWidget {
  const AddMoreBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: Colors.black12,
          splashColor: Colors.grey,
          onTap: () {
            BlocProvider.of<ImagePickerBlock>(context).add(AddMoreImages());
          },
          child: Ink(
            color: Colors.black.withOpacity(0.6),
            width: 50,
            height: 50,
            child: Center(
              child: SvgPicture.asset('images/plus.svg'),
            ),
          ),
        ),
      ),
    );
  }
}

class CarouselArrow extends StatelessWidget {
  const CarouselArrow({
    super.key,
    required this.changeCurrent,
    this.bottom,
    this.left,
    this.right,
    this.top,
    required this.icon,
    required this.size,
  });
  final Function changeCurrent;
  final Widget icon;
  final double? top;
  final double? right;
  final double? left;
  final double? bottom;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      bottom: bottom,
      child: ElevatedButton(
        onPressed: () {
          changeCurrent();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size(size, size),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        child: icon,
      ),
    );
  }
}

class AddMoreDeleteBtn extends StatelessWidget {
  const AddMoreDeleteBtn(
      {super.key, required this.currentImage, required this.showPreviousPopUp});
  final Function showPreviousPopUp;
  final int currentImage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      right: 5,
      child: ElevatedButton(
        onPressed: () {
          if (BlocProvider.of<ImagePickerBlock>(context)
                  .state
                  .webImages
                  ?.length ==
              1) {
            showPreviousPopUp();
          }
          BlocProvider.of<ImagePickerBlock>(context).add(
            DeleteImage(
              index: currentImage,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size(25, 25),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        child: SvgPicture.asset(
          'images/delete.svg',
          color: Colors.white,
        ),
      ),
    );
  }
}
