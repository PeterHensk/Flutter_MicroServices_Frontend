import '../car.dart';

class GetAllSessionsDto {
  final int id;
  final Car car;
  final int userId;
  final String stationIdentifier;
  final String portIdentifier;
  final double kwh;
  final String started;
  final String ended;

  GetAllSessionsDto({
    required this.id,
    required this.car,
    required this.userId,
    required this.stationIdentifier,
    required this.portIdentifier,
    required this.kwh,
    required this.started,
    required this.ended,
  });

  factory GetAllSessionsDto.fromJson(Map<String, dynamic> json) {
    return GetAllSessionsDto(
      id: json['id'],
      car: Car.fromJson(json['car']),
      userId: json['userId'],
      stationIdentifier: json['stationIdentifier'],
      portIdentifier: json['portIdentifier'],
      kwh: json['kwh'].toDouble(),
      started: json['started'],
      ended: json['ended'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car': car.toJson(),
      'userId': userId,
      'stationIdentifier': stationIdentifier,
      'portIdentifier': portIdentifier,
      'kwh': kwh,
      'started': started,
      'ended': ended,
    };
  }
}