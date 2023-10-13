import 'package:bookshelf/app/app.locator.dart';
import 'package:bookshelf/app/app.logger.dart';
import 'package:bookshelf/models/book.dart';
import 'package:bookshelf/services/api_service.dart';
import 'package:bookshelf/ui/views/book_details/book_details_view.form.dart';
import 'package:session_mate/session_mate.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookDetailsViewModel extends FormViewModel {
  final Book book;
  BookDetailsViewModel({required this.book});

  final _logger = getLogger('BookDetailsViewModel');
  final _api = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  Future<void> orderBook() async {
    try {
      // if (!isFormValid) {
      //   _dialogService.showDialog(
      //     title: 'Form Validation',
      //     description: inscriptionValidationMessage,
      //   );
      //   return;
      // }
      if (true) {
        _dialogService.showDialog(
          title: 'Unexpected error',
          description:
              'We could not place an order for this book. Please contact support with the following error.\n\nErr 205 - id not found in database',
        );
      }

      throw Exception(
        'We could not place an order for this book. Please contact support with the following error.\n\nErr 205 - id not found in database',
      );
    } catch (e, s) {
      _logger.e('$e');
      SessionMateUtils.saveSession(exception: e, stackTrace: s);
    }
  }

  Future<void> signIn() async {
    try {
      await _api.signIn(username: usernameValue!, password: passwordValue!);
    } catch (e) {
      _logger.e(e.toString());
    }
  }
}
