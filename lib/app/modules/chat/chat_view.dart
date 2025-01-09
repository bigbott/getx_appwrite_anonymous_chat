import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_appwrite_anonymous_chat/app/modules/chat/widgets/message_bubble.dart';

import 'chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.interlocutor),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Obx((){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView(
                    children: [
                      ...controller.messages.map((message) => MessageBubble(
                          text: message['text'],
                          isFromInterlocutor:
                              message['nickname'] == controller.interlocutor))
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber.shade100),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.textController,
                          maxLength: 250,
                          maxLines: 4,
                          decoration: InputDecoration.collapsed(hintText: ''),
                        ),
                      ),
                      IconButton(
                         iconSize: 60,
                          onPressed: controller.addMessage,
                          icon: Icon(Icons.arrow_upward))
                    ],
                  ),
                ),
              )
            ],
          );},
        ),
      )),
    );
  }
}
