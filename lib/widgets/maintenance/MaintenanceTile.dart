import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data-access/facades/MaintenanceFacade.dart';
import '../../models/Dto/GetAllMaintenanceDto.dart';

class MaintenanceTile extends StatelessWidget {
  final GetAllMaintenanceDto maintenanceReport;
  final String token;
  final MaintenanceFacade maintenanceFacade;

  const MaintenanceTile({
    Key? key,
    required this.maintenanceReport,
    required this.token,
    required this.maintenanceFacade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return ListTile(
      title: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(maintenanceReport.issueDescription),
            const SizedBox(height: 4),
            Text('Category: ${maintenanceReport.issueCategory}'),
            Text('Status: ${maintenanceReport.status}'),
            Text('Report Date: ${dateFormat.format(maintenanceReport.creationDate)}'),
            Text('Maintenance date: ${dateFormat.format(maintenanceReport.maintenanceDate)}'),
            Text('Station: ${maintenanceReport.stationIdentifier}'),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}