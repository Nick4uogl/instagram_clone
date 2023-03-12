import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  const StoryItem(
      {super.key,
      this.author,
      this.assetPath = 'images/avatar1.png',
      this.isTranslating = false});
  final String? author;
  final String assetPath;
  final bool isTranslating;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        !isTranslating
            ? Container(
                padding: const EdgeInsets.all(3),
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xffFBAA47),
                      Color(0xffD91A46),
                      Color(0xffA60F93),
                    ],
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
                            image: AssetImage(assetPath), fit: BoxFit.cover)),
                  ),
                ),
              )
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
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
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 31,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            image: DecorationImage(
                                image: AssetImage(assetPath),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Positioned(
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
                          child: Text("LIVE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5)),
                        ),
                      )),
                ],
              ),
        const SizedBox(height: 5),
        Text(
          "$author",
          style: const TextStyle(
              fontSize: 12, letterSpacing: -0.01, color: Color(0xff262626)),
        )
      ],
    ));
  }
}
