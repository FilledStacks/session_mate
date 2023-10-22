import 'package:bookshelf/app/app.locator.dart';
import 'package:bookshelf/app/app.logger.dart';
import 'package:bookshelf/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'login_view.form.dart';

class LoginViewModel extends FormViewModel {
  final log = getLogger('LoginViewModel');

  final _navigationService = locator<NavigationService>();

  Future<void> login() async {
    log.i('email:$emailValue, password:$passwordValue');

    await Future.delayed(Duration(seconds: 2));

    _navigationService.replaceWithBooksListView();
  }
}
