import 'package:flutter/material.dart';
import '../../models/Dto/GetAllStationsDto.dart';
import '../widgets/station/StationDetails.dart';

class StationDetailPage extends StatelessWidget {
  final GetAllStationsDto station;

  const StationDetailPage({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station.stationIdentifier),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: StationDetails(station: station),
      ),
    );
  }
}

