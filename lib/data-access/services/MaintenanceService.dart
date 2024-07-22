import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/Dto/GetAllMaintenanceDto.dart';
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
}