import 'package:flutter/material.dart';
import '../../../models/Dto/GetAllStationsDto.dart';
import '../../screens/StationDetailPage.dart';

class StationTile extends StatelessWidget {
  final GetAllStationsDto station;

  const StationTile({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: Column(
          children: [
            Text(
              station.stationIdentifier,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Location: ${station.location.city}, ${station.location.country}'),
            Text('Charging Ports: ${station.chargingPorts.length}'),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StationDetailPage(station: station),
          ),
        );
      },
    );
  }
}
