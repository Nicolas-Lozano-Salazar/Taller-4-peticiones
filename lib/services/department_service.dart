import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/department.dart';

class DepartmentService {
  final http.Client _client;

  DepartmentService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Department>> getAll() async {
    final response = await _client.get(Uri.parse(ApiConfig.endpoint('Department')));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((e) => Department.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }

  Future<Department> getById(int id) async {
    final response =
        await _client.get(Uri.parse(ApiConfig.endpoint('Department/$id')));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Department.fromJson(data);
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }
}
