import 'package:example/app/app.locator.dart';
import 'package:example/app/app.logger.dart';
import 'package:example/services/dio_service.dart';
import 'package:example/services/http_service.dart';
import 'package:example/ui/views/home/home_view.form.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FormViewModel {
  final logger = getLogger('HomeViewModel');
  final _httpService = locator<HttpService>();
  final _dioService = locator<DioService>();

  String _feedback = '';
  String get feedback => _feedback;

  bool get isDioClient => httpClientValue == 'dio';

  void setupHttpClient() {
    setHttpClient('dio');
  }

  Future<void> getResources() async {
    try {
      _feedback = isDioClient
          ? await _dioService.getResources()
          : await _httpService.getResourcesInformation();
      rebuildUi();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getLocations() async {
    try {
      _feedback = isDioClient
          ? await _dioService.getLocations()
          : await _httpService.getLocations();
      rebuildUi();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getCharacters() async {
    try {
      _feedback = isDioClient
          ? await _dioService.getCharacters()
          : await _httpService.getCharacters();
      rebuildUi();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getEpisodes() async {
    try {
      _feedback = isDioClient
          ? await _dioService.getEpisodes()
          : await _httpService.getEpisodes();
      rebuildUi();
    } catch (e) {
      logger.e(e);
    }
  }
}
