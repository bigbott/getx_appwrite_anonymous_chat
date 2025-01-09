import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/messages_service.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/name_service.dart';

import 'app/routes/app_pages.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/users_service.dart';


void main() {
  UsersService.putInstance();
  MessagesService.putInstance();
  NameService.putInstance();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
