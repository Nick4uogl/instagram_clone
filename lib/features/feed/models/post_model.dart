class PostModel {
  PostModel({
    required this.id,
    required this.description,
    required this.img,
    required this.avatarImg,
    required this.location,
    required this.authorName,
    required this.likedBy,
    required this.likedByAvatarPath,
  });

  int id;
  String description;
  String img;
  String avatarImg;
  String location;
  String authorName;
  String likedBy;
  String likedByAvatarPath;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        description: json["description"],
        img: json["img"],
        avatarImg: json["avatarImg"],
        location: json["location"],
        authorName: json["authorName"],
        likedBy: json["likedBy"],
        likedByAvatarPath: json["likedByAvatarPath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "img": img,
        "avatarImg": avatarImg,
        "location": location,
        "authorName": authorName,
        "likedBy": likedBy,
        "likedByAvatarPath": likedByAvatarPath,
      };
}
