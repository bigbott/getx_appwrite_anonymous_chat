import 'package:get/get.dart';

import 'user_list_controller.dart';

class UserListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserListController>(
      () => UserListController(),
    );
  }
}
