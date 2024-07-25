import 'package:flutter/material.dart';
import '../../data-access/facades/MaintenanceFacade.dart';
import '../../data-access/services/MaintenanceService.dart';
import '../../models/Dto/GetAllMaintenanceDto.dart';
import 'package:intl/intl.dart';

import '../../models/Dto/UpdateMaintenanceDto.dart';

class MaintenanceDetailsDialog extends StatefulWidget {
  final GetAllMaintenanceDto maintenanceReport;
  final String token;
  final VoidCallback onEditSuccess;

  const MaintenanceDetailsDialog({
    Key? key,
    required this.maintenanceReport,
    required this.token,
    required this.onEditSuccess,
  }) : super(key: key);

  @override
  _MaintenanceDetailsDialogState createState() =>
      _MaintenanceDetailsDialogState();
}

class _MaintenanceDetailsDialogState extends State<MaintenanceDetailsDialog> {
  late TextEditingController _issueDescriptionController;
  late TextEditingController _stationIdentifierController;
  late TextEditingController _maintenanceDateController;
  String? _selectedIssueCategory;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _issueDescriptionController =
        TextEditingController(text: widget.maintenanceReport.issueDescription);
    _stationIdentifierController =
        TextEditingController(text: widget.maintenanceReport.stationIdentifier);
    _maintenanceDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd HH:mm')
            .format(widget.maintenanceReport.maintenanceDate));
    _selectedIssueCategory = widget.maintenanceReport.issueCategory;
    _selectedStatus = widget.maintenanceReport.status;
  }

  @override
  void dispose() {
    _issueDescriptionController.dispose();
    _stationIdentifierController.dispose();
    _maintenanceDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Maintenance Report Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _issueDescriptionController,
              decoration: const InputDecoration(labelText: 'Issue Description'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Station Identifier: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_stationIdentifierController.text),
                ],
              ),
            ),
            TextFormField(
              controller: _maintenanceDateController,
              decoration: const InputDecoration(labelText: 'Maintenance Date'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedIssueCategory,
              decoration: const InputDecoration(labelText: 'Issue Category'),
              items: const [
                DropdownMenuItem(
                    value: "ELECTRICAL", child: Text("Electrical")),
                DropdownMenuItem(
                    value: "MECHANICAL", child: Text("Mechanical")),
                DropdownMenuItem(value: "SOFTWARE", child: Text("Software")),
                DropdownMenuItem(value: "OTHER", child: Text("Other")),
              ],
              onChanged: (value) =>
                  setState(() => _selectedIssueCategory = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select an issue category';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: InputDecoration(labelText: 'Status'),
              items: const [
                DropdownMenuItem(value: "PENDING", child: Text("Pending")),
                DropdownMenuItem(
                    value: "IN_PROGRESS", child: Text("In progress")),
                DropdownMenuItem(value: "COMPLETED", child: Text("Completed")),
                DropdownMenuItem(value: "CANCELLED", child: Text("Cancelled")),
                DropdownMenuItem(value: "REQUESTED", child: Text("Requested")),
              ],
              onChanged: (value) => setState(() => _selectedStatus = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a status';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            try {
              UpdateMaintenanceDto updateDto = UpdateMaintenanceDto(
                issueDescription: _issueDescriptionController.text,
                maintenanceDate: DateFormat('yyyy-MM-dd HH:mm').parse(_maintenanceDateController.text),
                issueCategory: _selectedIssueCategory!,
                status: _selectedStatus!,
              );
              MaintenanceService maintenanceService = MaintenanceService();
              MaintenanceFacade maintenanceFacade = MaintenanceFacade(maintenanceService);
              await maintenanceFacade.updateMaintenanceReport(widget.token, widget.maintenanceReport.id, updateDto);
              Navigator.of(context).pop();
              widget.onEditSuccess();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Maintenance report updated successfully')));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update maintenance report: $e')));
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
