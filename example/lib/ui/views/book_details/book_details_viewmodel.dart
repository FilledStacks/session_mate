import 'package:bookshelf/app/app.locator.dart';
import 'package:bookshelf/app/app.logger.dart';
import 'package:bookshelf/models/book.dart';
import 'package:session_mate/session_mate.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookDetailsViewModel extends FormViewModel {
  final Book book;
  BookDetailsViewModel({required this.book});

  final _logger = getLogger('BookDetailsViewModel');
  final _dialogService = locator<DialogService>();

  double _quantity = 1;
  double get quantity => _quantity;

  Future<void> orderBook() async {
    try {
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

  void updateSlider(double value) {
    _quantity = value;
    rebuildUi();
  }
}
