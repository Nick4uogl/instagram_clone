import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firstapp/core/data/icons.dart';

class Post extends StatefulWidget {
  const Post(
      {super.key,
      required this.id,
      required this.authorName,
      required this.location,
      required this.isOriginalProfile,
      required this.imageList,
      this.likedBy,
      this.othersLikesNumber,
      this.description,
      required this.authorAvatarPath,
      this.likedByAvatarPath});

  final String id;
  final String authorName;
  final String location;
  final bool isOriginalProfile;
  final List<Image> imageList;
  final String? likedBy;
  final int? othersLikesNumber;
  final String? description;
  final String? likedByAvatarPath;
  final String authorAvatarPath;

  @override
  State<StatefulWidget> createState() {
    return _Post();
  }
}

class _Post extends State<Post> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  void changeCurrent(int index) {
    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          PostHeader(
              authorName: widget.authorName,
              location: widget.location,
              authorAvatarPath: widget.authorAvatarPath,
              isOriginalProfile: widget.isOriginalProfile),
          PostSlider(
              imageList: widget.imageList,
              current: _current,
              controller: _controller,
              changeCurrent: changeCurrent,
              id: widget.id),
          PostActions(
              imageList: widget.imageList,
              controller: _controller,
              current: _current),
          if (widget.likedBy != null)
            PostLikes(
              likedByAvatarPath: widget.likedByAvatarPath,
              likedBy: widget.likedBy,
              othersLikesNumber: widget.othersLikesNumber,
            ),
          if (widget.description != null)
            PostDescription(
              authorName: widget.authorName,
              description: widget.description,
            )
        ],
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  const PostHeader(
      {super.key,
      required this.authorName,
      required this.location,
      required this.isOriginalProfile,
      required this.authorAvatarPath});

  final String authorName;
  final String location;
  final bool isOriginalProfile;
  final String authorAvatarPath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(authorAvatarPath),
            radius: 16,
          ),
        ],
      ),
      title: Row(
        children: [
          Text(
            "${authorName}",
            style: const TextStyle(
                fontSize: 13, letterSpacing: -0.1, fontWeight: FontWeight.w600),
          ),
          if (isOriginalProfile) const SizedBox(width: 4),
          if (isOriginalProfile) originalIcon
        ],
      ),
      minLeadingWidth: 32,
      contentPadding: const EdgeInsets.only(left: 10, right: 10),
      subtitle: Text(
        "${location}",
        style: const TextStyle(
          fontSize: 11,
          letterSpacing: 0.07,
          color: Color(0xff262626),
        ),
      ),
      trailing: const Icon(Icons.more_horiz, color: Colors.black),
    );
  }
}

class PostSlider extends StatelessWidget {
  const PostSlider(
      {super.key,
      required this.imageList,
      required this.current,
      required this.controller,
      required this.changeCurrent,
      required this.id});
  final List<Image> imageList;
  final int current;
  final CarouselController controller;
  final Function changeCurrent;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final curr = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarouselTaped(
              imageList: imageList,
              current: current,
              id: id,
            ),
          ),
        );
        changeCurrent(curr);
        controller.animateToPage(current);
      },
      child: Stack(clipBehavior: Clip.none, children: [
        Hero(
          tag: id,
          child: CarouselSlider(
            items: imageList,
            carouselController: controller,
            options: CarouselOptions(
                height: MediaQuery.of(context).size.width,
                initialPage: current,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  changeCurrent(index);
                }),
          ),
        ),
        if (imageList.length > 1)
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              width: 45,
              height: 26,
              decoration: BoxDecoration(
                  color: const Color(0xb3121212),
                  borderRadius: BorderRadius.circular(13)),
              child: Center(
                child: Text(
                  '${current + 1} / ${imageList.length}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
      ]),
    );
  }
}

class CarouselTaped extends StatefulWidget {
  const CarouselTaped(
      {super.key,
      required this.imageList,
      required this.id,
      required this.current});
  final List<Image> imageList;
  final String id;
  final int current;

  @override
  State<CarouselTaped> createState() => _CarouselTapedState();
}

class _CarouselTapedState extends State<CarouselTaped> {
  late int current;

  @override
  void initState() {
    current = widget.current;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Hero(
            tag: widget.id,
            child: CarouselSlider(
              items: widget.imageList,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  initialPage: widget.current,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  }),
            ),
          ),
          if (widget.imageList.length > 1)
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                width: 45,
                height: 26,
                decoration: BoxDecoration(
                    color: const Color(0xb3121212),
                    borderRadius: BorderRadius.circular(13)),
                child: Center(
                  child: Text(
                    '${current + 1} / ${widget.imageList.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, current),
            ),
          ),
        ],
      ),
    );
  }
}

class PostActions extends StatelessWidget {
  const PostActions(
      {super.key,
      required this.imageList,
      required this.controller,
      required this.current});
  final List<Widget> imageList;
  final int current;
  final CarouselController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        children: [
          Row(
            children: [
              IconButton(onPressed: null, icon: likeIcon),
              IconButton(onPressed: null, icon: commentIcon),
              IconButton(onPressed: null, icon: messengerIcon),
              const Spacer(),
              IconButton(onPressed: null, icon: saveIcon),
            ],
          ),
          if (imageList.length > 1)
            PostSliderDots(
              imageList: imageList,
              controller: controller,
              current: current,
            )
        ],
      ),
    );
  }
}

class PostSliderDots extends StatelessWidget {
  const PostSliderDots(
      {super.key,
      required this.imageList,
      required this.controller,
      required this.current});
  final List<Widget> imageList;
  final int current;
  final CarouselController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => controller.animateToPage(entry.key),
            child: Container(
              width: 6.0,
              height: 6.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current == entry.key
                    ? const Color(0xff3897F0)
                    : const Color(0x26000000),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class PostLikes extends StatelessWidget {
  PostLikes(
      {super.key,
      this.likedByAvatarPath,
      this.likedBy,
      this.othersLikesNumber});
  final String? likedByAvatarPath;
  final String? likedBy;
  final int? othersLikesNumber;
  final formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: null,
            icon: CircleAvatar(
              backgroundImage: AssetImage(likedByAvatarPath!),
              radius: 8.5,
            )),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                  text: 'Liked by ',
                  style: TextStyle(color: Color(0xff262626))),
              TextSpan(
                  text: "${likedBy} ",
                  style: const TextStyle(
                      color: Color(0xff262626), fontWeight: FontWeight.w600)),
              if (othersLikesNumber != null)
                const TextSpan(
                    text: 'and ', style: TextStyle(color: Color(0xff262626))),
              if (othersLikesNumber != null)
                (othersLikesNumber! > 999)
                    ? TextSpan(
                        text: '${formatter.format(othersLikesNumber)} ',
                        style: const TextStyle(
                            color: Color(0xff262626),
                            fontWeight: FontWeight.w600),
                      )
                    : TextSpan(
                        text: '${othersLikesNumber} ',
                        style: const TextStyle(
                            color: Color(0xff262626),
                            fontWeight: FontWeight.w600),
                      ),
              (othersLikesNumber != null && othersLikesNumber! > 1)
                  ? const TextSpan(
                      text: 'others',
                      style: TextStyle(
                          color: Color(0xff262626),
                          fontWeight: FontWeight.w600),
                    )
                  : const TextSpan(
                      text: 'other person',
                      style: TextStyle(
                          color: Color(0xff262626),
                          fontWeight: FontWeight.w600),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

class PostDescription extends StatelessWidget {
  const PostDescription({super.key, this.authorName, this.description});
  final String? authorName;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '${authorName} ',
                  style: const TextStyle(
                      color: Color(0xff262626), fontWeight: FontWeight.w600)),
              TextSpan(
                  text: '${description}',
                  style: const TextStyle(color: Color(0xff262626)))
            ],
          ),
        ),
      ),
    );
  }
}
