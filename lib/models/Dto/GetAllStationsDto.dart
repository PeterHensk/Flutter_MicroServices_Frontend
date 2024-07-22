import '../chargingPort.dart';
import '../location.dart';
import '../station.dart';

class GetAllStationsDto {
  final String stationIdentifier;
  final Location location;
  final List<ChargingPort> chargingPorts;
  final String imageId;
  final dynamic image;
  final dynamic contentType;

  GetAllStationsDto({
    required this.stationIdentifier,
    required this.location,
    required this.chargingPorts,
    required this.imageId,
    this.image,
    this.contentType,
  });

  factory GetAllStationsDto.fromJson(Map<String, dynamic> json) {
    var portsList = json['chargingPorts'] as List;
    List<ChargingPort> chargingPortsList = portsList.map((i) => ChargingPort.fromJson(i)).toList();

    return GetAllStationsDto(
      stationIdentifier: json['stationIdentifier'],
      location: Location.fromJson(json['location']),
      chargingPorts: chargingPortsList,
      imageId: json['imageId'],
      image: json['image'],
      contentType: json['contentType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stationIdentifier': stationIdentifier,
      'location': location.toJson(),
      'chargingPorts': chargingPorts.map((e) => e.toJson()).toList(),
      'imageId': imageId,
      'image': image,
      'contentType': contentType,
    };
  }

  Station toStation() {
    return Station(
      stationIdentifier: stationIdentifier,
      location: location,
      chargingPorts: chargingPorts,
      imageId: imageId,
      image: image,
      contentType: contentType,
    );
  }
}

