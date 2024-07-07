import 'dart:convert';

import 'package:frontend/data-access/facades/PageResponse.dart';
import 'package:frontend/models/Dto/GetAllUsersDto.dart';
import 'package:frontend/models/Dto/UpdateUserDto.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = 'http://localhost:8081/user';

  static const String whoAmI = '$_baseUrl/whoami';

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
      Uri.parse('$_baseUrl?page=$page&size=$size'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return PageResponse<GetAllUsersDto>.fromJson(
          jsonDecode(response.body),
              (item) => GetAllUsersDto.fromJson(item)
      );
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<http.Response> updateUser(int id, UpdateUserDto user) {
    Map<String, dynamic> userMap = user.toJson();
    String userJson = jsonEncode(userMap);
    return http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: userJson,
    );
  }

  Future<http.Response> updateUserField(GetAllUsersDto user, String field, String value) {
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
}