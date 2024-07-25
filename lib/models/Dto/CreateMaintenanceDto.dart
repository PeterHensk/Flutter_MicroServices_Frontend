class CreateMaintenanceDto {
  final String stationIdentifier;
  final String issueCategory;
  final String issueDescription;
  final DateTime creationDate;
  final String status;

  CreateMaintenanceDto({
    required this.stationIdentifier,
    required this.issueCategory,
    required this.issueDescription,
    required this.creationDate,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'stationIdentifier': stationIdentifier,
      'issueCategory': issueCategory,
      'issueDescription': issueDescription,
      'creationDate': creationDate.toIso8601String(),
      'status': status,
    };
  }
}