import 'dart:convert';

import 'package:frontend/data-access/facades/PageResponse.dart';
import 'package:frontend/models/Dto/GetAllUsersDto.dart';
import 'package:frontend/models/Dto/UpdateUserDto.dart';
import 'package:http/http.dart' as http;

import '../../models/Dto/CreateCarDto.dart';
import '../../models/Dto/GetAllSessionsDto.dart';
import '../../models/Dto/RunningSessionDto.dart';
import '../../models/Dto/StartSessionDto.dart';

class SessionService {
  static const String _baseUrl = 'http://localhost:8081';

  static const String whoAmI = '$_baseUrl/user/whoami';

  static Future<http.Response> postWhoAmI(String token) {
    return http.post(
      Uri.parse(whoAmI),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<PageResponse<GetAllUsersDto>> getAllUsers(int page, int size) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/user?page=$page&size=$size'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return PageResponse<GetAllUsersDto>.fromJson(
          jsonDecode(response.body), (item) => GetAllUsersDto.fromJson(item));
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<http.Response> updateUser(int id, UpdateUserDto user) {
    Map<String, dynamic> userMap = user.toJson();
    String userJson = jsonEncode(userMap);
    return http.put(
      Uri.parse('$_baseUrl/user/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: userJson,
    );
  }

  Future<http.Response> updateUserField(
      GetAllUsersDto user, String field, String value) {
    UpdateUserDto updatedUser = UpdateUserDto(
      id: user.id,
      email: field == 'email' ? value : user.email,
      firstName: field == 'firstName' ? value : user.firstName,
      lastName: field == 'lastName' ? value : user.lastName,
      role: field == 'role' ? value : user.role,
      updated: DateTime.now(),
    );
    return updateUser(updatedUser.id, updatedUser);
  }

  Future<PageResponse<GetAllSessionsDto>> getAllSessions(
      int page, int size) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/session?page=$page&size=$size'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return PageResponse<GetAllSessionsDto>.fromJson(jsonDecode(response.body),
          (item) => GetAllSessionsDto.fromJson(item));
    } else {
      throw Exception('Failed to load sessions');
    }
  }

  Future<http.Response> deleteSession(int sessionId) async {
    final url = Uri.parse('$_baseUrl/session/$sessionId');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response> startSession(
      String token, StartSessionDto sessionDto) async {
    final url = Uri.parse('$_baseUrl/session/start');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(sessionDto.toJson()),
    );
    return response;
  }

  Future<void> stopSession(String token, int sessionId) async {
    final url = Uri.parse('$_baseUrl/session/stop/$sessionId');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to stop session');
    }
  }

  Future<RunningSessionDto?> getRunningSession(String token) async {
    final url = Uri.parse('$_baseUrl/session/running');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return RunningSessionDto.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw Exception('Failed to load running session');
    }
  }

  Future<http.Response> createCar(String token, CreateCarDto carDto) async {
    final url = Uri.parse('$_baseUrl/car');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(carDto.toJson()),
    );
    return response;
  }
}
