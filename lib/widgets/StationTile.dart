import 'package:flutter/material.dart';
import '../../models/Dto/GetAllStationsDto.dart';

class StationTile extends StatelessWidget {
  final GetAllStationsDto station;

  const StationTile({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(station.stationIdentifier),
      subtitle: Text('Location: ${station.location.city}, ${station.location.country}'),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Navigate to station details or perform other actions
      },
    );
  }
}