import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';
import '../models/location.dart';

class ApiService {
  static const baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Character>> fetchCharacters(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/character?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => Character.fromJson(json))
          .toList();
    } else {
      throw Exception('Erro ao carregar personagens');
    }
  }

  Future<Character> fetchCharacterById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/character/$id'));

    if (response.statusCode == 200) {
      return Character.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao carregar personagem');
    }
  }

  Future<List<Location>> fetchLocations(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/location?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => Location.fromJson(json))
          .toList();
    } else {
      throw Exception('Erro ao carregar locais');
    }
  }
}
