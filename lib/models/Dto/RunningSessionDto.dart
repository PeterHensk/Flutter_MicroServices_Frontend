class RunningSessionDto {
  final int id;
  final String licensePlate;
  final String stationIdentifier;
  final String portIdentifier;
  final String started;

  RunningSessionDto({
    required this.id,
    required this.licensePlate,
    required this.stationIdentifier,
    required this.portIdentifier,
    required this.started,
  });

  factory RunningSessionDto.fromJson(Map<String, dynamic> json) {
    return RunningSessionDto(
      id: json['id'],
      licensePlate: json['car']['licensePlate'],
      stationIdentifier: json['stationIdentifier'],
      portIdentifier: json['portIdentifier'],
      started: json['started'],
    );
  }
}