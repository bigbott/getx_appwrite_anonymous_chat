
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/appwrite.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/secret_constants.dart';

class UsersService extends GetxService {

  static putInstance() =>
      Get.put<UsersService>(UsersService(), permanent: true);

  Future<void> loadUsers(users) async {
    DocumentList? res;
    try {
      res = await appwrite.databases.listDocuments(
        databaseId: SecretConstants.APPWRITE_DB_ID,
        collectionId: SecretConstants.APPWRITE_COLLECTION_USERS_ID,
      );
      users.clear();
      users.addAll(
          List<Map<String, dynamic>>.from(res.documents.map((e) => e.data)));
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  Future<void> addUser(String name) async {
    try {
      await appwrite.databases.createDocument(
        databaseId: SecretConstants.APPWRITE_DB_ID,
        collectionId: SecretConstants.APPWRITE_COLLECTION_USERS_ID,
        documentId: ID.unique(),
        data: {'nickname': name},
      );
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await appwrite.databases.deleteDocument(
        databaseId: SecretConstants.APPWRITE_DB_ID,
        collectionId: SecretConstants.APPWRITE_COLLECTION_USERS_ID,
        documentId: id,
      );
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  void subscribe(users) {
    final realtime = Realtime(appwrite.client);

   RealtimeSubscription subscription = realtime.subscribe([
      'documents' // subscribe to all documents in every database and collection
    ]);

    subscription.stream.listen((data) {
      final event = data.events.first;
      if (data.payload.isNotEmpty) {
        if (event.endsWith('.create')) {
          var user = data.payload;
          users.value.add(user);
          users.refresh();
        } else if (event.endsWith('.delete')) {
          var user = data.payload;
          users.value.removeWhere((it) => it['\$id'] == user['\$id']);
          users.refresh();
        }
      }
    });

  }    

}