import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/messages_service.dart';
import 'package:getx_appwrite_anonymous_chat/app/modules/user_list/user_list_controller.dart';

class ChatController extends GetxController {

  final MessagesService messagesService = Get.find<MessagesService>();


  final messages = List<Map<String, dynamic>>.empty().obs;

  final _interlocutor = ''.obs;
  String get interlocutor => _interlocutor.value;
  set interlocutor(val) => _interlocutor.value = val;

  final textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMessages();
    subscribe();
  }

  void loadMessages() async {
    messagesService.loadMessages(messages);
  }

  void subscribe() {
    messagesService.subscribe(messages);
  }

  void addMessage() async {
    var text = textController.text;
    var nickname = Get.find<UserListController>().name;
    if (text.isNotEmpty) {
      messagesService.addMessage(nickname, text);
    }
    textController.clear();
  }

  void deleteMessage(String id) async {
    messagesService.deleteMessage(id);
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
