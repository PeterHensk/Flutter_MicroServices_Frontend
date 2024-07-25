import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/Dto/CreateMaintenanceDto.dart';
import '../../models/Dto/GetAllMaintenanceDto.dart';
import '../../models/Dto/UpdateMaintenanceDto.dart';
import '../facades/PageResponse.dart';

class MaintenanceService {
  static const String _baseUrl = 'http://localhost:8083/maintenance';

  Future<PageResponse<GetAllMaintenanceDto>> getMaintenanceReports(String token, int page, int size, {String sort = 'creationDate,desc'}) async {
    final url = Uri.parse('$_baseUrl/report?page=$page&size=$size&sort=$sort');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return PageResponse<GetAllMaintenanceDto>.fromJson(
          jsonDecode(response.body),
              (item) => GetAllMaintenanceDto.fromJson(item)
      );
    } else {
      throw Exception('Failed to load maintenance reports');
    }
  }
  Future<void> createMaintenanceReport(String token, CreateMaintenanceDto dto) async {
    final url = Uri.parse(_baseUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create maintenance report');
    }
  }

  Future<void> updateMaintenanceReport(String token, int reportId, UpdateMaintenanceDto dto) async {
    final url = Uri.parse('$_baseUrl/$reportId');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update maintenance report');
    }
  }

  Future<http.Response> deleteMaintenance(String token, int maintenanceId) async {
    final url = Uri.parse('$_baseUrl/$maintenanceId');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

}