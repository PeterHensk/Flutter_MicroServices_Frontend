class UpdateUserDto {
  int id;
  String email;
  String firstName;
  String lastName;
  String role;
  DateTime updated;

  UpdateUserDto({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.updated,

  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emailAddress': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'updated': updated.toIso8601String(),
    };
  }
}