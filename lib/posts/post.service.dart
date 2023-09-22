import 'package:get/get.dart';

import 'post.model.dart';

class PostService extends GetConnect {
  final GetConnect connect = Get.find<GetConnect>();

  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com';

  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> posts = [];
    try {
      Response response = await connect.get('$baseUrl/posts');
      if (response.statusCode == 200) {
        // print(response.body.runtimeType); // List<dynamic>
        // print(response.body[1].runtimeType);  // _jsonMap
        for (var jsonPost in response.body) {
          posts.add(PostModel.fromJson(jsonPost));
        }
      }
    } catch (error) {
      throw Exception(error);
    }
    return posts;
  }

  Future<PostModel?> getPostById(int postId) async {
    try {
      Response response = await connect.get('$baseUrl/posts/$postId');
      if (response.statusCode == 200) {
        PostModel post = PostModel.fromJson(response.body);
        return post;
      } else {
        return null;
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
