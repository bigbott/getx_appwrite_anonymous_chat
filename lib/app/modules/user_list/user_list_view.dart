import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_appwrite_anonymous_chat/app/modules/chat/chat_controller.dart';
import 'package:getx_appwrite_anonymous_chat/app/routes/app_pages.dart';

import 'user_list_controller.dart';

class UserListView extends GetView<UserListController> {
  const UserListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users online'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () {
            return ListView(
              children: [
                ...controller.users.map((user) => ListTile(
                      title: Center(child: Text(user['nickname'])),
                      onTap: () {
                        Get.put<ChatController>(ChatController()).interlocutor = user['nickname'];
                        Get.toNamed(Routes.CHAT);
                      },
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
