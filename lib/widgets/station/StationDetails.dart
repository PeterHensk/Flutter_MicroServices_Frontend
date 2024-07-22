import 'package:flutter/material.dart';
import '../../data-access/facades/MaintenanceFacade.dart';
import '../../data-access/facades/SessionFacade.dart';
import '../../models/Dto/GetAllStationsDto.dart';
import '../../screens/StationManagement.dart';
import 'CreateSessionWidget.dart';

class StationDetails extends StatelessWidget {
  final GetAllStationsDto station;
  final String token;
  final SessionFacade sessionFacade;
  final MaintenanceFacade maintenanceFacade;

  const StationDetails({super.key, required this.station,
                                   required this.token,
                                   required this.sessionFacade,
                                   required this.maintenanceFacade});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Location: ${station.location.city}, ${station.location.country}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.headlineLarge?.color ??
                  Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Address: ${station.location.addressLine1}, ${station.location.postalCode}',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.headlineMedium?.color ??
                  Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Parking: ${station.location.parkingName}',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.headlineMedium?.color ??
                  Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Charging Ports:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.headlineSmall?.color ??
                  Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: station.chargingPorts.map((port) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: brightness == Brightness.dark
                              ? Colors.grey[700]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            'Port Identifier: ${port.portIdentifier}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Status: ${port.status}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.color ??
                                  Colors.black54,
                            ),
                          ),
                          trailing: port.status == "AVAILABLE"
                              ? CreateSessionWidget(
                                  stationIdentifier: station.stationIdentifier,
                                  portIdentifier: port.portIdentifier,
                                  onSessionCreated: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StationManagement(
                                              token: token,
                                              sessionFacade: sessionFacade,
                                              maintenanceFacade: maintenanceFacade)),
                                    );
                                  },
                                )
                              : null,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
