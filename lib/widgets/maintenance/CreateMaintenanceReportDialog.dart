import 'package:flutter/material.dart';
import '../../data-access/facades/MaintenanceFacade.dart';
import '../../models/Dto/CreateMaintenanceDto.dart';

class CreateMaintenanceReportDialog extends StatefulWidget {
  final String stationIdentifier;
  final String token;
  final MaintenanceFacade maintenanceFacade;

  const CreateMaintenanceReportDialog({
    Key? key,
    required this.stationIdentifier,
    required this.token,
    required this.maintenanceFacade,
  }) : super(key: key);

  @override
  _CreateMaintenanceReportDialogState createState() => _CreateMaintenanceReportDialogState();
}

class _CreateMaintenanceReportDialogState extends State<CreateMaintenanceReportDialog> {
  final _formKey = GlobalKey<FormState>();
  late String issueCategory;
  late String issueDescription;
  late String status;
  DateTime creationDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    issueCategory = "ELECTRICAL";
    status = "PENDING";
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final CreateMaintenanceDto dto = CreateMaintenanceDto(
        stationIdentifier: widget.stationIdentifier,
        issueCategory: issueCategory,
        issueDescription: issueDescription,
        creationDate: creationDate,
        status: status,
      );
      widget.maintenanceFacade.createMaintenanceReport(widget.token, dto).then((_) {
        Navigator.of(context).pop();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting report: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Report Issue for Station ${widget.stationIdentifier}'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: issueCategory,
                decoration: const InputDecoration(labelText: 'Issue Category'),
                items: const [
                  DropdownMenuItem(value: "ELECTRICAL", child: Text("Electrical")),
                  DropdownMenuItem(value: "MECHANICAL", child: Text("Mechanical")),
                  DropdownMenuItem(value: "SOFTWARE", child: Text("Software")),
                  DropdownMenuItem(value: "OTHER", child: Text("Other")),
                ],
                onChanged: (value) => setState(() => issueCategory = value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an issue category';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: status,
                decoration: InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: "PENDING", child: Text("Pending")),
                  DropdownMenuItem(value: "IN_PROGRESS", child: Text("In progress")),
                  DropdownMenuItem(value: "COMPLETED", child: Text("Completed")),
                  DropdownMenuItem(value: "CANCELLED", child: Text("Cancelled")),
                  DropdownMenuItem(value: "REQUESTED", child: Text("Requested")),
                ],
                onChanged: (value) => setState(() => status = value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a status';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Issue Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an issue description';
                  }
                  return null;
                },
                onSaved: (value) => issueDescription = value!,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _submitForm,
          child: const Text('Submit'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}