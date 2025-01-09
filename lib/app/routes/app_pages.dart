import 'package:get/get.dart';

import '../modules/chat/chat_binding.dart';
import '../modules/chat/chat_view.dart';
import '../modules/user_list/user_list_binding.dart';
import '../modules/user_list/user_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.USER_LIST;

  static final routes = [

    GetPage(
      name: _Paths.USER_LIST,
      page: () => const UserListView(),
      binding: UserListBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
