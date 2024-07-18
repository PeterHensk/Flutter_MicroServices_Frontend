class Car {
  final int id;
  final String brand;
  final String model;
  final String licensePlate;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.licensePlate,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      licensePlate: json['licensePlate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'licensePlate': licensePlate,
    };
  }
}