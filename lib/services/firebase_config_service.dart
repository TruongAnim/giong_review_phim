import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConfigService {
  FirebaseConfigService._();
  static final FirebaseConfigService _instance = FirebaseConfigService._();
  static FirebaseConfigService get instance => _instance;
  static String configCollection = 'configs';

  Future<String?> getConfig(String document, String key) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection(configCollection)
        .doc(document)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot.get(key);
    } else {
      return null;
    }
  }
}
