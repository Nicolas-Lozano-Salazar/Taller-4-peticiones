import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/typical_dish.dart';

class TypicalDishService {
  final http.Client _client;

  TypicalDishService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<TypicalDish>> getAll() async {
    final response =
        await _client.get(Uri.parse(ApiConfig.endpoint('TypicalDish')));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((e) => TypicalDish.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }

  Future<TypicalDish> getById(int id) async {
    final response =
        await _client.get(Uri.parse(ApiConfig.endpoint('TypicalDish/$id')));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return TypicalDish.fromJson(data);
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }
}
