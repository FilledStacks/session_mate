import 'package:bookshelf/ui/widgets/common/book_card/book_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'books_list_viewmodel.dart';

class BooksListView extends StackedView<BooksListViewModel> {
  const BooksListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BooksListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookshelf')),
      body: SafeArea(
        child: viewModel.isBusy
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : viewModel.dataReady
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.4,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 80,
                    ),
                    shrinkWrap: true,
                    itemCount: viewModel.data?.length,
                    itemBuilder: (context, index) => BookCard(
                      book: viewModel.data![index],
                      onTap: () {
                        viewModel.onTap(viewModel.data![index]);
                      },
                    ),
                  )
                : const SizedBox.shrink(),
      ),
    );
  }

  @override
  BooksListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BooksListViewModel();
}
