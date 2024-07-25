// UpdateMaintenanceDto.dart
class UpdateMaintenanceDto {
  final String issueDescription;
  final DateTime maintenanceDate;
  final String issueCategory;
  final String status;

  UpdateMaintenanceDto({
    required this.issueDescription,
    required this.maintenanceDate,
    required this.issueCategory,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'issueDescription': issueDescription,
    'maintenanceDate': maintenanceDate.toIso8601String(),
    'issueCategory': issueCategory,
    'status': status,
  };
}