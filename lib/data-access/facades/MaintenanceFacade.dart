
import 'package:frontend/data-access/services/MaintenanceService.dart';

import '../../models/Dto/GetAllMaintenanceDto.dart';
import 'PageResponse.dart';

class MaintenanceFacade {
  final MaintenanceService _maintenanceService;

  MaintenanceFacade(this._maintenanceService);

  Future<PageResponse<GetAllMaintenanceDto>> getMaintenanceReports(String token, int pageIndex, int pageSize) async {
    try {
      final PageResponse<GetAllMaintenanceDto> response = await _maintenanceService.getMaintenanceReports(token, pageIndex, pageSize);
      return response;
    } catch (error) {
      throw Exception('Failed to fetch maintenance reports: $error');
    }
  }
}