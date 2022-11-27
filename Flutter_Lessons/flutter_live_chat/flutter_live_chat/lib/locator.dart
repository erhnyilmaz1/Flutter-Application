import 'package:flutter_live_chat/repository/user_repository.dart';
import 'package:flutter_live_chat/services/firebase_auth_fake_service.dart';
import 'package:flutter_live_chat/services/firebase_auth_service.dart';
import 'package:flutter_live_chat/services/firestorage_service.dart';
import 'package:flutter_live_chat/services/firestore_service.dart';
import 'package:flutter_live_chat/services/sent_notification_service.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirebaseAuthFakeService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => FirestorageService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => SentNotificationService());
}
