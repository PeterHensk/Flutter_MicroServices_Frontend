class UserDto {
  final String firstName;
  final String lastName;

  UserDto({required this.firstName, required this.lastName});

  UserDto.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
      };
}
