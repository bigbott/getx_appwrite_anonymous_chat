import 'package:get/get.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/name_service.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/users_service.dart';

class UserListController extends GetxController {
  final users = List<Map<String, dynamic>>.empty().obs;

  final usersService = Get.find<UsersService>();
  final nameService = Get.find<NameService>();
  late String name; //nickname of current user

  @override
  void onInit() async {
    super.onInit();
    await addUser();
    await loadUsers();
    subscribe();
  }

  Future<void> loadUsers() async {
    usersService.loadUsers(users);
  }

  void subscribe() {
    usersService.subscribe(users);
  }

  Future<void> addUser() async {
    name = nameService.generateName();
    usersService.addUser(name);
  }

  void deleteUser(String id) async {
    usersService.deleteUser(id);
  }

  @override
  void onClose() {
    for (var user in users){
      if (name == user['nickname']){
        deleteUser(user['\$id']);
      }
    }
    super.onClose();
  }
}
