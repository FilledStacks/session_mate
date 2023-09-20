import 'package:bookshelf/ui/widgets/common/book_card.dart';
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
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1 / 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 80,
                    ),
                    shrinkWrap: true,
                    itemCount: viewModel.data?.length,
                    itemBuilder: (context, index) => BookCard(
                      book: viewModel.data![index].copyWith(id: index),
                      onTap: () {
                        viewModel.onTap(viewModel.data![index].copyWith(
                          id: index,
                        ));
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
