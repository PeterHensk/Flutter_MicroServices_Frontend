import 'package:flutter/material.dart';
import '../../models/Dto/GetAllStationsDto.dart';
import '../data-access/facades/MaintenanceFacade.dart';
import '../data-access/facades/SessionFacade.dart';
import '../widgets/station/StationDetails.dart';

class StationDetailPage extends StatelessWidget {
  final GetAllStationsDto station;
  final String token;
  final SessionFacade sessionFacade;
  final MaintenanceFacade maintenanceFacade;

  const StationDetailPage({super.key, required this.station,
                                      required this.token,
                                      required this.sessionFacade,
                                      required this.maintenanceFacade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station.stationIdentifier),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: StationDetails(
            station: station,
            token: token,
            sessionFacade: sessionFacade,
            maintenanceFacade: maintenanceFacade,),
      ),
    );
  }
}

