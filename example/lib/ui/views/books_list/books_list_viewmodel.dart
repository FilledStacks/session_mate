import 'package:bookshelf/app/app.locator.dart';
import 'package:bookshelf/app/app.logger.dart';
import 'package:bookshelf/app/app.router.dart';
import 'package:bookshelf/fake_data/fake_book.dart';
import 'package:bookshelf/models/book.dart';
import 'package:bookshelf/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const kUseFakeData = bool.fromEnvironment('USE_FAKE_DATA');

class BooksListViewModel extends FutureViewModel<List<Book>> {
  final _logger = getLogger('BooksListViewModel');
  final _api = locator<ApiService>();
  final _navigationService = locator<NavigationService>();

  @override
  Future<List<Book>> futureToRun() => getBooks();

  Future<List<Book>> getBooks({String genreType = 'computers'}) async {
    _logger.i('');

    if (kUseFakeData) {
      await Future.delayed(const Duration(seconds: 1));

      return FakeBook().generateFakeList(length: 100);
    }

    return (await _api.getBooks()).toList();
  }

  void onTap(Book book) {
    _logger.i(book.title);

    _navigationService.navigateToBookDetailsView(book: book);
  }

  void showSettings() {
    _navigationService.navigateToSettingsView();
  }
}
