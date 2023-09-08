import 'package:bookshelf/models/book.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final void Function()? onTap;
  const BookCard({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (book.imageLinks == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          book.imageLinks!.smallThumbnail,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
