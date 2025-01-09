
import 'package:appwrite/appwrite.dart';
import 'package:getx_appwrite_anonymous_chat/app/data/secret_constants.dart';

final appwrite = _Appwrite();

class _Appwrite {

  static const APPWRITE_ENDPOINT = 'https://cloud.appwrite.io/v1';

 
   _Appwrite() {
     _initAppwrite();
   }
  
  late final Client client;
  late final Account account;
  late final Databases databases;


  void _initAppwrite() {
    client = Client()
        .setEndpoint(APPWRITE_ENDPOINT)
        .setProject(SecretConstants.APPWRITE_PROJECT_ID);

    account = Account(client);
    databases = Databases(client);
  }

}