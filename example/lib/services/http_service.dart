import 'dart:convert';

import 'package:example/app/app.logger.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static const String domain = 'rickandmortyapi.com';
  static const String resources = 'api';
  static const String characters = 'api/character';
  static const String locations = 'api/location';
  static const String episodes = 'api/episode';

  final logger = getLogger('HttpService');

  Future<String> getResourcesInformation() async {
    final url = Uri.https(domain, resources);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return """
      method: ${response.request?.method}
      url: ${response.request?.url}
      statusCode: ${response.statusCode}
      resources: ${data.keys.map((e) => e)}
    """;
  }

  Future<String> getCharacters() async {
    final url = Uri.https(domain, characters);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return """
      method: ${response.request?.method}
      url: ${response.request?.url}
      statusCode: ${response.statusCode}
      Number of Characters: ${data['info']['count']}
    """;
  }

  Future<String> getLocations() async {
    final url = Uri.https(domain, locations);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return """
      method: ${response.request?.method}
      url: ${response.request?.url}
      statusCode: ${response.statusCode}
      Number of Locations: ${data['info']['count']}
    """;
  }

  Future<String> getEpisodes() async {
    final url = Uri.https(domain, episodes);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return """
      method: ${response.request?.method}
      url: ${response.request?.url}
      statusCode: ${response.statusCode}
      Number of Episodes: ${data['info']['count']}
    """;
  }
}
