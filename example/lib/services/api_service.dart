import 'dart:convert';

import 'package:bookshelf/models/book.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'www.googleapis.com';
  static const String books = '/books/v1/volumes';

  Future<Iterable<Book>> getBooks({String genreType = 'computers'}) async {
    final url = Uri.https(baseUrl, books, {'q': 'subject:$genreType'});
    final response = await http.get(url);
    final Iterable data = jsonDecode(response.body)['items'];

    return data.map((e) => Book.fromJson(e['volumeInfo']));
  }
}
