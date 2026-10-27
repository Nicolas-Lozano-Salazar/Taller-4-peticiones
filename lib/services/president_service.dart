import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/president.dart';

class PresidentService {
  final http.Client _client;

  PresidentService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<President>> getAll() async {
    final response = await _client.get(Uri.parse(ApiConfig.endpoint('President')));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((e) => President.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }

  Future<President> getById(int id) async {
    final response =
        await _client.get(Uri.parse(ApiConfig.endpoint('President/$id')));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return President.fromJson(data);
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }
}
