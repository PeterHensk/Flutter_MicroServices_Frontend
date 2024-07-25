import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data-access/facades/MaintenanceFacade.dart';
import '../../models/Dto/GetAllMaintenanceDto.dart';
import '../general/ConfirmDeleteDialog.dart';
import '../general/HoverMenuWidget.dart';
import 'MaintenanceDetailsDialog.dart';

class MaintenanceTile extends StatelessWidget {
  final GetAllMaintenanceDto maintenanceReport;
  final String token;
  final MaintenanceFacade maintenanceFacade;
  final VoidCallback onMaintenanceDeleted;

  const MaintenanceTile({
    super.key,
    required this.maintenanceReport,
    required this.token,
    required this.maintenanceFacade,
    required this.onMaintenanceDeleted,
  });

  void deleteReport(BuildContext context, int reportId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          onConfirm: () async {
            try {
              await maintenanceFacade.deleteReport(token, reportId);
              onMaintenanceDeleted();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Maintenance report deleted successfully')));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to delete maintenance report: $e')));
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return HoverMenuWidget(
      actions: const [HoverMenuAction.edit, HoverMenuAction.delete],
      onEdit: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MaintenanceDetailsDialog(
              maintenanceReport: maintenanceReport,
              token: token,
              onEditSuccess: onMaintenanceDeleted,
            );
          },
        );
      },
      onDelete: () => deleteReport(context, maintenanceReport.id),
      child: ListTile(
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(maintenanceReport.issueDescription),
              const SizedBox(height: 4),
              Text('Category: ${maintenanceReport.issueCategory}'),
              Text('Status: ${maintenanceReport.status}'),
              Text(
                  'Report Date: ${dateFormat.format(maintenanceReport.creationDate)}'),
              Text(
                  'Maintenance date: ${dateFormat.format(maintenanceReport.maintenanceDate)}'),
              Text('Station: ${maintenanceReport.stationIdentifier}'),
            ],
          ),
        ),
      ),
    );
  }
}
