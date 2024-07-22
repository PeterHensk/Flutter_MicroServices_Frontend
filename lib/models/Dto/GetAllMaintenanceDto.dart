class GetAllMaintenanceDto {
  final DateTime creationDate;
  final DateTime maintenanceDate;
  final String status;
  final String issueDescription;
  final String issueCategory;
  final String stationIdentifier;
  final int totalCompletedSessions;

  GetAllMaintenanceDto({
    required this.creationDate,
    required this.maintenanceDate,
    required this.status,
    required this.issueDescription,
    required this.issueCategory,
    required this.stationIdentifier,
    required this.totalCompletedSessions,
  });

  factory GetAllMaintenanceDto.fromJson(Map<String, dynamic> json) {
    return GetAllMaintenanceDto(
      creationDate: DateTime.parse(json['creationDate']),
      maintenanceDate: DateTime.parse(json['maintenanceDate']),
      status: json['status'],
      issueDescription: json['issueDescription'],
      issueCategory: json['issueCategory'],
      stationIdentifier: json['station']['stationIdentifier'],
      totalCompletedSessions: json['totalCompletedSessions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creationDate': creationDate.toIso8601String(),
      'maintenanceDate': maintenanceDate.toIso8601String(),
      'status': status,
      'issueDescription': issueDescription,
      'issueCategory': issueCategory,
      'station': {
        'stationIdentifier': stationIdentifier,
      },
      'totalCompletedSessions': totalCompletedSessions,
    };
  }
}