class CreateCarDto {
  final String brand;
  final String model;
  final String licensePlate;

  CreateCarDto({
    required this.brand,
    required this.model,
    required this.licensePlate,
  });

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'model': model,
      'licensePlate': licensePlate,
    };
  }
}