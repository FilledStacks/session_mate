import 'dart:convert';

import 'package:bookshelf/app/app.logger.dart';
import 'package:bookshelf/models/book.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'www.googleapis.com';
  static const String books = '/books/v1/volumes';

  final _logger = getLogger('ApiService');

  Future<Iterable<Book>> getBooks({String genreType = 'computers'}) async {
    try {
      final url = Uri.https(baseUrl, books, {'q': 'subject:$genreType'});
      final response = await http.get(url);

      if (response.statusCode == 429) {
        throw Exception(jsonDecode(response.body)['error']['message']);
      }

      final Iterable data = jsonDecode(response.body)['items'];

      return data.map((e) => Book.fromJson(e['volumeInfo']));
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }
}
