import 'package:get_it/get_it.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate/src/services/session_service.dart';

final locator = GetIt.asNewInstance();

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => DriverCommunicationService());
  locator.registerLazySingleton(() => SessionService());

  final hiveStorage = HiveService();
  await hiveStorage.init();
  locator.registerSingleton(hiveStorage);
}
