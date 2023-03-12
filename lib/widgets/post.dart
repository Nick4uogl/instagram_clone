import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firstapp/data/icons.dart';

class Post extends StatefulWidget {
  const Post(
      {super.key,
      required this.authorName,
      required this.location,
      this.isOriginalProfile = false,
      required this.imageList,
      this.likedBy,
      this.othersLikesNumber,
      this.description,
      required this.authorAvatarPath,
      this.likedByAvatarPath});

  final String authorName;
  final String location;
  final bool isOriginalProfile;
  final List<Widget> imageList;
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
  var formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.authorAvatarPath),
                  radius: 16,
                ),
              ],
            ),
            title: Row(
              children: [
                Text(
                  "${widget.authorName}",
                  style: const TextStyle(
                      fontSize: 13,
                      letterSpacing: -0.1,
                      fontWeight: FontWeight.w600),
                ),
                if (widget.isOriginalProfile) const SizedBox(width: 4),
                if (widget.isOriginalProfile) originalIcon
              ],
            ),
            minLeadingWidth: 32,
            contentPadding: const EdgeInsets.only(left: 10, right: 10),
            subtitle: Text(
              "${widget.location}",
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.07,
                color: Color(0xff262626),
              ),
            ),
            trailing: const Icon(Icons.more_horiz, color: Colors.black),
          ),
          Stack(clipBehavior: Clip.none, children: [
            CarouselSlider(
              items: widget.imageList,
              carouselController: _controller,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.width,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
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
                      '${_current + 1} / ${widget.imageList.length}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ]),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Stack(children: [
              Row(
                children: [
                  IconButton(onPressed: null, icon: likeIcon),
                  IconButton(onPressed: null, icon: commentIcon),
                  IconButton(onPressed: null, icon: messengerIcon),
                  const Spacer(),
                  IconButton(onPressed: null, icon: saveIcon),
                ],
              ),
              if (widget.imageList.length > 1)
                Container(
                  margin: const EdgeInsets.only(top: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 6.0,
                            height: 6.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == entry.key
                                  ? const Color(0xff3897F0)
                                  : const Color(0x26000000),
                            ),
                          ));
                    }).toList(),
                  ),
                ),
            ]),
          ),
          if (widget.likedBy != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: null,
                    icon: CircleAvatar(
                      backgroundImage: AssetImage(widget.likedByAvatarPath!),
                      radius: 8.5,
                    )),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Liked by ',
                          style: TextStyle(color: Color(0xff262626))),
                      TextSpan(
                          text: "${widget.likedBy} ",
                          style: const TextStyle(
                              color: Color(0xff262626),
                              fontWeight: FontWeight.w600)),
                      if (widget.othersLikesNumber != null)
                        const TextSpan(
                            text: 'and ',
                            style: TextStyle(color: Color(0xff262626))),
                      if (widget.othersLikesNumber != null)
                        (widget.othersLikesNumber! > 999)
                            ? TextSpan(
                                text:
                                    '${formatter.format(widget.othersLikesNumber)} ',
                                style: const TextStyle(
                                    color: Color(0xff262626),
                                    fontWeight: FontWeight.w600),
                              )
                            : TextSpan(
                                text: '${widget.othersLikesNumber} ',
                                style: const TextStyle(
                                    color: Color(0xff262626),
                                    fontWeight: FontWeight.w600),
                              ),
                      (widget.othersLikesNumber != null &&
                              widget.othersLikesNumber! > 1)
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
            ),
          if (widget.description != null)
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '${widget.authorName} ',
                          style: const TextStyle(
                              color: Color(0xff262626),
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: '${widget.description}',
                          style: const TextStyle(color: Color(0xff262626)))
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
