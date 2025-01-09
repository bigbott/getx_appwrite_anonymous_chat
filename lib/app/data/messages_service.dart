
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/appwrite.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/secret_constants.dart';

class MessagesService extends GetxService {

  static putInstance() =>
      Get.put<MessagesService>(MessagesService(), permanent: true);

  Future<void> loadMessages(messages) async {
    DocumentList? res;
    try {
      res = await appwrite.databases.listDocuments(
        databaseId: SecretConstants.APPWRITE_DB_ID,
        collectionId: SecretConstants.APPWRITE_COLLECTION_MESSAGES_ID,
      );
      messages.clear();
      messages.addAll(
          List<Map<String, dynamic>>.from(res.documents.map((e) => e.data)));
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  Future<void> addMessage(String nickname, String text) async {
    try {
      await appwrite.databases.createDocument(
        databaseId: SecretConstants.APPWRITE_DB_ID,
        collectionId: SecretConstants.APPWRITE_COLLECTION_MESSAGES_ID,
        documentId: ID.unique(),
        data: {'nickname': nickname, 'text': text},
      );
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  Future<void> deleteMessage(String id) async {
    try {
      await appwrite.databases.deleteDocument(
        databaseId: SecretConstants.APPWRITE_DB_ID,
        collectionId: SecretConstants.APPWRITE_COLLECTION_MESSAGES_ID,
        documentId: id,
      );
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  void subscribe(messages) {
    final realtime = Realtime(appwrite.client);

   RealtimeSubscription subscription = realtime.subscribe([
      'documents' // subscribe to all documents in every database and collection
    ]);

    subscription.stream.listen((data) {
      final event = data.events.first;
      if (data.payload.isNotEmpty) {
        if (event.endsWith('.create')) {
          var message = data.payload;
          messages.value.add(message);
          messages.refresh();
        } else if (event.endsWith('.delete')) {
          var message = data.payload;
          messages.value.removeWhere((it) => it['\$id'] == message['\$id']);
          messages.refresh();
        }
      }
    });

  }    

}