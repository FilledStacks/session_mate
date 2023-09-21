import 'package:bookshelf/models/book.dart';
import 'package:bookshelf/ui/common/ui_helpers.dart';
import 'package:bookshelf/ui/views/book_details/book_details_validator.dart';
import 'package:bookshelf/ui/views/book_details/book_details_view.form.dart';
import 'package:bookshelf/ui/widgets/common/book_identifier.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'book_details_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'inscription', validator: BookDetailsValidator.validate),
])
class BookDetailsView extends StackedView<BookDetailsViewModel>
    with $BookDetailsView {
  final Book book;
  const BookDetailsView({super.key, required this.book});

  @override
  Widget builder(
    BuildContext context,
    BookDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookshelf')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (book.imageLinks != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Image.network(
                        book.imageLinks!.thumbnail,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned.fill(
                        child: Center(
                          child: BookIdentifier(
                            id: '${book.id}',
                            small: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              verticalSpaceMedium,
              Text(book.title, style: Theme.of(context).textTheme.titleLarge),
              verticalSpaceSmall,
              Text(
                book.authors.map((e) => e).join(', '),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              if (book.description != null) ...[
                verticalSpaceMedium,
                Text(
                  book.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              verticalSpaceLarge,
              Text(
                'Custom Inscription',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              verticalSpaceTiny,
              TextFormField(
                controller: inscriptionController,
                // decoration: const InputDecoration(
                //   filled: true,
                //   fillColor: Color(0xFF232228),
                // ),
                maxLines: 5,
              ),
              verticalSpaceLarge,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: viewModel.orderBook,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF514DC3),
                    foregroundColor: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Order Book',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(BookDetailsViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(BookDetailsViewModel viewModel) {
    disposeForm();
  }

  @override
  BookDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BookDetailsViewModel(book: book);
}
