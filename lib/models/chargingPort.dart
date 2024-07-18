class ChargingPort {
  final String? chargingPortId;
  final String portIdentifier;
  final String status;

  ChargingPort({
    this.chargingPortId,
    required this.portIdentifier,
    required this.status,
  });

  factory ChargingPort.fromJson(Map<String, dynamic> json) {
    return ChargingPort(
      chargingPortId: json['chargingPortId'],
      portIdentifier: json['portIdentifier'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chargingPortId': chargingPortId,
      'portIdentifier': portIdentifier,
      'status': status,
    };
  }
}