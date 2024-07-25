import 'dart:convert';
import 'package:frontend/data-access/facades/PageResponse.dart';
import 'package:frontend/models/Dto/GetAllStationsDto.dart';
import 'package:http/http.dart' as http;

class StationService {
  static const String _baseUrl = 'http://localhost:8080/station';

  Future<PageResponse<GetAllStationsDto>> getAllStations(String token, int page, int size, {String sort = 'creationDate,desc'}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?page=$page&size=$size&sort=$sort'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return PageResponse<GetAllStationsDto>.fromJson(
          jsonDecode(response.body),
              (item) => GetAllStationsDto.fromJson(item)
      );
    } else {
      throw Exception('Failed to load stations');
    }
  }
}