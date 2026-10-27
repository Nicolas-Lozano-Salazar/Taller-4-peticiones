import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/airport.dart';

class AirportService {
  final http.Client _client;

  AirportService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Airport>> getAll() async {
    final response = await _client.get(Uri.parse(ApiConfig.endpoint('Airport')));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((e) => Airport.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }

  Future<Airport> getById(int id) async {
    final response =
        await _client.get(Uri.parse(ApiConfig.endpoint('Airport/$id')));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Airport.fromJson(data);
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }
}
