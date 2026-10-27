import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/touristic_attraction.dart';

class TouristicAttractionService {
  final http.Client _client;

  TouristicAttractionService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<TouristicAttraction>> getAll() async {
    final response =
        await _client.get(Uri.parse(ApiConfig.endpoint('TouristicAttraction')));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((e) => TouristicAttraction.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }

  Future<TouristicAttraction> getById(int id) async {
    final response = await _client
        .get(Uri.parse(ApiConfig.endpoint('TouristicAttraction/$id')));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return TouristicAttraction.fromJson(data);
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }
}
