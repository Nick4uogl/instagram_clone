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
            "$author",
            style: const TextStyle(
                fontSize: 12, letterSpacing: -0.01, color: Color(0xff262626)),
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
  late List<bool> viewedStories;

  @override
  void initState() {
    viewedStories = List.generate(widget.images.length, (index) => false);
    super.initState();
  }

  void changeViewedStories(int index) {
    setState(() {
      viewedStories[index] = true;
    });
  }

  bool isAllViewed() {
    int viewed = 0;
    for (var i in viewedStories) {
      if (i) {
        viewed++;
      }
    }
    if (viewed == viewedStories.length) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var colorsList = isAllViewed()
        ? [
            Color(0xffDEDCDC),
            Color(0xffDEDCDC),
          ]
        : [
            Color(0xffFBAA47),
            Color(0xffD91A46),
            Color(0xffA60F93),
          ];
    return !widget.isTranslating
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StorySlider(
                    images: widget.images,
                    author: widget.author,
                    changeViewedStories: changeViewedStories,
                  ),
                ),
              );
            },
            child: StoryAvatar(
              assetPath: widget.assetPath,
              colors: colorsList,
            ),
          )
        : GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StorySlider(
                    images: widget.images,
                    author: widget.author,
                    changeViewedStories: changeViewedStories,
                  ),
                ),
              );
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
          border: Border.all(width: 2, color: Colors.white),
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
                letterSpacing: 0.5),
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
        backgroundColor: Colors.white,
        radius: 31,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            image: DecorationImage(
                image: AssetImage(assetPath), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class StorySlider extends StatefulWidget {
  const StorySlider(
      {super.key,
      required this.images,
      required this.author,
      required this.changeViewedStories});
  final List<Widget> images;
  final String author;
  final Function changeViewedStories;

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
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_current == widget.images.length - 1) {
            Navigator.pop(context);
          }
          changeCurrent();
        },
        child: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: (_current != widget.images.length)
                    ? widget.images[_current]
                    : widget.images[_current - 1]),
            Positioned(
              top: 8,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width,
                height: 2,
                child: Row(
                  children: List.generate(
                    widget.images.length,
                    (index) {
                      return Flexible(
                        child: Padding(
                          padding: (index != widget.images.length - 1)
                              ? const EdgeInsets.only(right: 8)
                              : const EdgeInsets.only(right: 0),
                          child: StoryProgressIndicator(
                            indicatorId: index,
                            current: _current,
                            storiesLength: widget.images.length,
                            changeCurrent: changeCurrent,
                            changeViewedStories: widget.changeViewedStories,
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
  const StoryProgressIndicator(
      {super.key,
      required this.indicatorId,
      required this.current,
      required this.storiesLength,
      required this.changeCurrent,
      required this.changeViewedStories});
  final int indicatorId;
  final int current;
  final int storiesLength;
  final Function changeCurrent;
  final Function changeViewedStories;

  @override
  State<StoryProgressIndicator> createState() => _StoryProgressIndicatorState();
}

class _StoryProgressIndicatorState extends State<StoryProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

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

    controller.addListener(() {
      if (controller.isCompleted) {
        widget.changeViewedStories(widget.indicatorId);
        if (widget.current == widget.indicatorId) {
          widget.changeCurrent();
        }
        if (widget.current == widget.storiesLength - 1) {
          Navigator.pop(context);
        }
      }
    });
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
