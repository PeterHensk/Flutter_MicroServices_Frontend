import 'package:intl/intl.dart';

class GetAllUsersDto {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String updated;
  final String role;

  GetAllUsersDto({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.updated,
    required this.role,
  });

  factory GetAllUsersDto.fromJson(Map<String, dynamic> json) {
    String updated = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(json['updated']));
    return GetAllUsersDto(
      id: json['id'],
      email: json['emailAddress'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      updated: updated,
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emailAddress': email,
      'firstName': firstName,
      'lastName': lastName,
      'updated': updated,
      'role': role,
    };
  }
}