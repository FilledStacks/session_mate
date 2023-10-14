import 'dart:convert';

import 'package:bookshelf/app/app.logger.dart';
import 'package:bookshelf/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

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

  Future<dynamic> getAuthors({bool forceXML = false}) async {
    try {
      final contentType = forceXML ? '.xml' : '';
      final url = Uri.https('thetestrequest.com', '/authors$contentType');
      final response = await http.get(url);

      // print(
      //     '🤡 statusCode:${response.statusCode} ${response.headers['content-type']} body:${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Unexpected response');
      }

      // final document = XmlDocument.parse(response.body);
      // final objectsList = document.findElements('objects').single;
      // final objects = objectsList.findElements('object');

      // for (var o in objects) {
      //   print(o.findElements('id').single);
      //   print(o.findElements('name').single);
      //   print(o.findElements('email').single);
      //   print(o.findElements('avatar').single);
      // }

      return {};
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  Future<dynamic> getAuthor({
    required String authorId,
    bool forceXML = false,
  }) async {
    try {
      final contentType = forceXML ? '.xml' : '';
      final url = Uri.https(
        'thetestrequest.com',
        '/authors/$authorId$contentType',
      );
      final response = await http.get(url);

      print('🤡 statusCode:${response.statusCode} body:${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Unexpected response');
      }

      final document = XmlDocument.parse(response.body);
      final author = document.findElements('hash').single;

      print(author.findElements('name').single.innerText);

      return {};
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }
}
