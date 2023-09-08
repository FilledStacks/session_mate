import 'package:bookshelf/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:bookshelf/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:bookshelf/ui/views/home/home_view.dart';
import 'package:bookshelf/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bookshelf/ui/views/books_list/books_list_view.dart';
import 'package:bookshelf/services/api_service.dart';
import 'package:bookshelf/ui/views/book_details/book_details_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: BooksListView),
    MaterialRoute(page: BookDetailsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApiService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
