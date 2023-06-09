import 'package:firstapp/features/stories/models/story_model.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  const StoryItem(
      {super.key,
      required this.author,
      this.assetPath = 'images/avatar1.png',
      this.isTranslating = false,
      required this.images});
  final String author;
  final String assetPath;
  final bool isTranslating;
  final List<Widget> images;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StoryCircle(
            author: author,
            assetPath: assetPath,
            images: images,
            isTranslating: isTranslating,
          ),
          const SizedBox(height: 5),
          Text(
            author,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: -0.01,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}

class StoryCircle extends StatefulWidget {
  const StoryCircle(
      {super.key,
      required this.images,
      required this.author,
      required this.assetPath,
      required this.isTranslating});
  final String author;
  final String assetPath;
  final List<Widget> images;
  final bool isTranslating;

  @override
  State<StoryCircle> createState() => _StoryCircle();
}

class _StoryCircle extends State<StoryCircle> {
  bool isViewed = false;

  void changeIsViewed() {
    setState(() {
      isViewed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorsList = isViewed
        ? [
            const Color(0xffDEDCDC),
            const Color(0xffDEDCDC),
          ]
        : [
            const Color(0xffFBAA47),
            const Color(0xffD91A46),
            const Color(0xffA60F93),
          ];
    return !widget.isTranslating
        ? GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(
                StorySlider.routeName,
                arguments: StoryModel(
                  images: widget.images,
                  author: widget.author,
                  changeIsViewed: changeIsViewed,
                ),
              );
              // final result = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => StorySlider(
              //       images: widget.images,
              //       author: widget.author,
              //     ),
              //   ),
              // );
            },
            child: StoryAvatar(
              assetPath: widget.assetPath,
              colors: colorsList,
            ),
          )
        : GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => StorySlider(
              //       images: widget.images,
              //       author: widget.author,
              //     ),
              //   ),
              // );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                StoryAvatar(
                  assetPath: widget.assetPath,
                  colors: const [
                    Color(0xffE20337),
                    Color(0xffC60188),
                    Color(0xff7700C3),
                  ],
                ),
                const LiveLabel(),
              ],
            ),
          );
  }
}

class LiveLabel extends StatelessWidget {
  const LiveLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55,
      left: 20,
      child: Container(
        width: 28,
        height: 18,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          borderRadius: BorderRadius.circular(3),
          gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffE20337),
              Color(0xffC60188),
              Color(0xff7700C3),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "LIVE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class StoryAvatar extends StatelessWidget {
  const StoryAvatar({super.key, required this.assetPath, required this.colors});
  final String assetPath;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
          colors: colors,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        radius: 31,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            image: DecorationImage(
              image: AssetImage(assetPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class StorySlider extends StatefulWidget {
  const StorySlider({super.key});
  static const routeName = '/story';
  @override
  State<StorySlider> createState() => _StorySliderState();
}

class _StorySliderState extends State<StorySlider> {
  int _current = 0;

  void changeCurrent() {
    setState(() {
      _current = _current + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as StoryModel;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_current == args.images.length - 1) {
            args.changeIsViewed();
            Navigator.pop(context);
          }
          changeCurrent();
        },
        child: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: (_current != args.images.length)
                    ? args.images[_current]
                    : args.images[_current - 1]),
            Positioned(
              top: 8,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width,
                height: 2,
                child: Row(
                  children: List.generate(
                    args.images.length,
                    (index) {
                      return Flexible(
                        child: Padding(
                          padding: (index != args.images.length - 1)
                              ? const EdgeInsets.only(right: 8)
                              : const EdgeInsets.only(right: 0),
                          child: StoryProgressIndicator(
                            changeIsViewed: args.changeIsViewed,
                            indicatorId: index,
                            current: _current,
                            storiesLength: args.images.length,
                            changeCurrent: changeCurrent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryProgressIndicator extends StatefulWidget {
  const StoryProgressIndicator({
    super.key,
    required this.indicatorId,
    required this.current,
    required this.storiesLength,
    required this.changeCurrent,
    required this.changeIsViewed,
  });
  final int indicatorId;
  final int current;
  final int storiesLength;
  final Function changeCurrent;
  final Function changeIsViewed;

  @override
  State<StoryProgressIndicator> createState() => _StoryProgressIndicatorState();
}

class _StoryProgressIndicatorState extends State<StoryProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  void listenToAnimation() {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.current == widget.indicatorId) {
          widget.changeCurrent();
        }
        if (widget.current == widget.storiesLength - 1) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.changeIsViewed();
            Navigator.pop(context, true);
          });
        }
      }
    });
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    if (widget.indicatorId == widget.current) {
      controller.animateTo(1);
    }

    listenToAnimation();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.indicatorId < widget.current) {
      controller.animateTo(1, duration: Duration.zero);
    }
    if (widget.indicatorId == widget.current) {
      controller.animateTo(1);
    }
    return LinearProgressIndicator(
      value: controller.value,
      color: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.36),
      semanticsLabel: 'Linear progress indicator',
    );
  }
}
