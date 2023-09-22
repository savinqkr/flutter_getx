import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'post.model.dart';
import 'post.service.dart';

class PostScreen extends HookWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put<GetConnect>(GetConnect());
    final PostService postService = Get.put(PostService());

    late Future<List<PostModel>> postsFuture;
    useEffect(() {
      postsFuture = postService.getAllPosts();
      // postService.getPostById(3);
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('POSTS'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data available.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return ListTile(
                  leading: Text('${post.postId}'),
                  title: Text(post.postTitle),
                  subtitle: Text(post.postBody),
                );
              },
            );
          }
        },
      ),
    );
  }
}
