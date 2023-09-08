class PostModel {
  String name, description, postUrl, profilePhoto,uid,postId;
  DateTime uploadDate;
  List likes;

  PostModel({
    required this.name,
    required this.description,
    required this.postUrl,
    required this.uid,
    required this.profilePhoto,
    required this.uploadDate,
    required this.postId,
    required this.likes,

  });
  Map<String, dynamic> toJson() => {
    'name' : name,
    'description' : description,
    'photoUrl' : postUrl,
    'uid' : uid,
    'profilePhoto' : profilePhoto,
    'postId' : postId,
    'likes' : likes,
    'uploadDate' : DateTime.now(),
  };
}
