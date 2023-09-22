class PostModel {
  final int postId;
  final String postTitle;
  final String postBody;
  final int userId;

  PostModel({
    required this.postId,
    required this.postTitle,
    required this.postBody,
    required this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // print(json);
    return PostModel(
      postId: json['id'],
      postTitle: json['title'],
      postBody: json['body'],
      userId: json['userId'],
    );
  }
}
