import 'package:flutter/material.dart';
import '../../../models/Dto/GetAllStationsDto.dart';
import '../../data-access/facades/MaintenanceFacade.dart';
import '../../data-access/facades/SessionFacade.dart';
import '../../screens/StationDetailPage.dart';
import '../general/HoverMenuWidget.dart';
import '../maintenance/CreateMaintenanceReportDialog.dart';

class StationTile extends StatelessWidget {
  final GetAllStationsDto station;
  final String token;
  final SessionFacade sessionFacade;
  final MaintenanceFacade maintenanceFacade;

  const StationTile({super.key, required this.station,
    required this.token,
    required this.sessionFacade,
    required this.maintenanceFacade});

  void editStation() {
    print("Edit station ${station.stationIdentifier}");
  }

  void deleteStation() {
    print("Delete station ${station.stationIdentifier}");
  }

  void reportStation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateMaintenanceReportDialog(
          stationIdentifier: station.stationIdentifier,
          token: token,
          maintenanceFacade: maintenanceFacade,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListTile(
        title: HoverMenuWidget(
          actions: const [HoverMenuAction.edit, HoverMenuAction.report, HoverMenuAction.delete],
          onEdit: editStation,
          onDelete: deleteStation,
          onReport: () => reportStation(context),
          child: Center(
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
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StationDetailPage(
                  station: station,
                  token: token,
                  sessionFacade: sessionFacade,
                  maintenanceFacade: maintenanceFacade),
            ),
          );
        },
      ),
    );
  }
}