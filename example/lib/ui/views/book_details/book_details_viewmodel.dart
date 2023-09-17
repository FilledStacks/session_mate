import 'package:bookshelf/app/app.locator.dart';
import 'package:bookshelf/models/book.dart';
import 'package:session_mate/session_mate.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookDetailsViewModel extends FormViewModel {
  final Book book;
  BookDetailsViewModel({required this.book});

  final _dialogService = locator<DialogService>();

  Future<void> orderBook() async {
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

    SessionMateUtils.saveSession();
  }
}
