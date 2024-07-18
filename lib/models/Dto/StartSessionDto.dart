class StartSessionDto {
  final String licensePlate;
  final String stationIdentifier;
  final String portIdentifier;

  StartSessionDto({
    required this.licensePlate,
    required this.stationIdentifier,
    required this.portIdentifier,
  });

  Map<String, dynamic> toJson() {
    return {
      'licensePlate': licensePlate,
      'stationIdentifier': stationIdentifier,
      'portIdentifier': portIdentifier,
    };
  }
}