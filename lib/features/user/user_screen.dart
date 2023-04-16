import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage(
      {Key? key,
      required this.author,
      required this.profileImagePath,
      required this.nickName,
      required this.posts,
      required this.followers,
      required this.following})
      : super(key: key);
  final String author;
  final String profileImagePath;
  final String nickName;
  final int posts;
  final int followers;
  final int following;

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                nickName,
                style: TextStyle(color: Theme.of(context).iconTheme.color),
              ),
              const Spacer(),
              Icon(
                Icons.more_vert,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      margin: EdgeInsets.only(right: screenWidth * 0.05),
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xffFBAA47),
                            Color(0xffD91A46),
                            Color(0xffA60F93),
                          ],
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        radius: 45,
                        child: Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(42),
                            image: DecorationImage(
                              image: AssetImage(profileImagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                '$posts',
                                style: TextStyle(
                                  color: Theme.of(context).iconTheme.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Posts',
                                style: TextStyle(
                                  color: Theme.of(context).iconTheme.color,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '$followers',
                                style: TextStyle(
                                  color: Theme.of(context).iconTheme.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Followers',
                                style: TextStyle(
                                  color: Theme.of(context).iconTheme.color,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '$following',
                                style: TextStyle(
                                  color: Theme.of(context).iconTheme.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Following',
                                style: TextStyle(
                                  color: Theme.of(context).iconTheme.color,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author,
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'digital goodies designer',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Everything is designed',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
