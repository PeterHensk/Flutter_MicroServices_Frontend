import 'chargingPort.dart';
import 'location.dart';

class Station {
  final String stationIdentifier;
  final Location location;
  final List<ChargingPort> chargingPorts;
  final String imageId;
  final dynamic image;
  final dynamic contentType;

  Station({
    required this.stationIdentifier,
    required this.location,
    required this.chargingPorts,
    required this.imageId,
    this.image,
    this.contentType,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    var portsList = json['chargingPorts'] as List;
    List<ChargingPort> chargingPortsList = portsList.map((i) => ChargingPort.fromJson(i)).toList();

    return Station(
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
}
