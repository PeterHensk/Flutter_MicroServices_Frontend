class Location {
  final String locationId;
  final String country;
  final String city;
  final String postalCode;
  final String addressLine1;
  final String parkingName;

  Location({
    required this.locationId,
    required this.country,
    required this.city,
    required this.postalCode,
    required this.addressLine1,
    required this.parkingName,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationId: json['locationId'],
      country: json['country'],
      city: json['city'],
      postalCode: json['postalCode'],
      addressLine1: json['addressLine1'],
      parkingName: json['parkingName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationId': locationId,
      'country': country,
      'city': city,
      'postalCode': postalCode,
      'addressLine1': addressLine1,
      'parkingName': parkingName,
    };
  }
}