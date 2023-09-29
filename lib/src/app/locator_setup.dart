import 'package:get_it/get_it.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/data_masking_service.dart';
import 'package:session_mate/src/services/driver_communication_service.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate/src/services/http_service.dart';
import 'package:session_mate/src/services/interceptor_service.dart';
import 'package:session_mate/src/services/native_inforamation_service.dart';
import 'package:session_mate/src/services/session_recording_service.dart';
import 'package:session_mate/src/services/session_replay_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate/src/utils/widget_finder.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';

final locator = GetIt.asNewInstance();

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => ConfigurationService());
  locator.registerLazySingleton(() => DriverCommunicationService());
  locator.registerLazySingleton(() => DataMaskingService());
  locator.registerLazySingleton(() => SessionService());
  locator.registerLazySingleton(() => SessionRecordingService());
  locator.registerLazySingleton(() => SessionReplayService());
  locator.registerLazySingleton(() => InterceptorService());
  locator.registerLazySingleton(() => WidgetFinder());
  locator.registerLazySingleton(() => SessionMateRouteTracker.instance);
  locator.registerLazySingleton(() => HttpService());

  final hiveStorage = HiveService();
  await hiveStorage.init();
  locator.registerSingleton(hiveStorage);

  final nativeInformationService = NativeInformationService();
  await nativeInformationService.intialise();
  locator.registerSingleton(nativeInformationService);
}
