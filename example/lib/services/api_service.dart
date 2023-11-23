import 'dart:convert';

import 'package:bookshelf/app/app.logger.dart';
import 'package:bookshelf/models/book.dart';
import 'package:http/http.dart' as http;

const String _baseUrl = String.fromEnvironment(
  'APP_BASE_URL',
  defaultValue: 'https://www.googleapis.com',
);
const String _booksPath = '/books/v1/volumes';

class ApiService {
  final _logger = getLogger('ApiService');

  final _baseUri = Uri.parse(_baseUrl);

  Future<Iterable<Book>> getBooks({String genreType = 'computers'}) async {
    try {
      final uri = _baseUri.replace(
        path: _booksPath,
        queryParameters: {'q': 'subject:$genreType'},
      );
      final response = await http.get(uri);

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
