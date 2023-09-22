import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/posts');
                    },
                    child: const Text('POSTS')),
                const SizedBox(height: 20),
                const Text("GetConnect 를 통한 API 통신 & FutureBuilder 를 이용한 렌더링")
              ],
            ),
            const SizedBox(height: 100),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/todos');
                    },
                    child: const Text('TODOS')),
                const SizedBox(height: 20),
                const Text("GetConnect 를 통한 API 통신 & GetView 를 이용한 렌더링")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
