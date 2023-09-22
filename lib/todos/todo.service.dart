import 'package:get/get.dart';

import 'todo.model.dart';

// 참고자료 : https://gist.github.com/eduardoflorence/b4bca2da5cfb973b9f86ecfa1b9f013a#file-main-dart-L68

// *** 아래에서부터 읽어주세요 ***

// ------------------------------------------------------------
// BINDING
// - 무슨 역할인지 아직 잘 모르겠음
// - 없어도 정상 작동함
// - 효율적인 메모리 관리를 위해 인스턴스를 시킨것을 어떻게 활용하고, 필요하지 않을 때는 인스턴스를 없애주는 과정이 필요
// - https://velog.io/@giyeon/flutter-3-2-Getx-%EC%A2%85%EC%86%8D%EC%84%B1-%EA%B4%80%EB%A6%AC-%EB%B0%94%EC%9D%B8%EB%94%A9
// - https://kanoos-stu.tistory.com/68
// - https://unsungit.tistory.com/64
// - https://medium.com/flutter-community/the-flutter-getx-ecosystem-dependency-injection-8e763d0ec6b9
// ------------------------------------------------------------
class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoProvider());
    Get.put(TodoController(todoProvider: Get.find()));
  }
}

// ------------------------------------------------------------
// CONTROLLER
// - PROVIDER 의 데이터를 가져오는 함수를 실행시킨 후,
// - 데이터를 정상적으로 받았을 경우와 아닐 경우에 대한 상태 처리
// - 즉, todo.screen.dart 에서 [ 데이터를 정상적으로 받았을 때 ], onLoading , onError 임을
//   인식하기 위한 상태를 처리해주는 곳
//   ( FutureBuilder 의 snapshot 안의 상태들을 만들어주는 과정이라고 이해하면 편함 )
// ------------------------------------------------------------
class TodoController extends GetxController with StateMixin<List<TodoModel>> {
  final TodoProvider todoProvider;
  TodoController({required this.todoProvider});

  @override
  void onInit() {
    getAllTodosByUserId();
    super.onInit();
  }

  void getAllTodosByUserId() {
    todoProvider.getAllTodosByUserId().then((response) {
      List<TodoModel> todos = [];

      for (var jsonTodo in response.body) {
        todos.add(TodoModel.fromJson(jsonTodo));
      }
      change(todos, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}

// ------------------------------------------------------------
// PROVIDER
// - 실제로 API 를 콜하여 데이터를 받아오는 부분
// ------------------------------------------------------------
class TodoProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = TodoModel.listFromJson;
  }

  Future<Response> getAllTodosByUserId() =>
      get('https://jsonplaceholder.typicode.com/users/1/todos');
}
