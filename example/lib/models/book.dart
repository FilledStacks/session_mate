import 'package:bookshelf/models/industry_identifiers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_links.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  Book._();

  factory Book({
    @Default(0) int id,
    required String title,
    required List<String> authors,
    String? publisher,
    String? publishedDate,
    String? description,
    List<IndustryIdentifiers>? industryIdentifiers,
    int? pageCount,
    String? printType,
    List<String>? categories,
    ImageLinks? imageLinks,
    String? language,
    String? previewLink,
    String? infoLink,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  factory Book.empty() => Book(
        title: '',
        authors: [],
      );
}
