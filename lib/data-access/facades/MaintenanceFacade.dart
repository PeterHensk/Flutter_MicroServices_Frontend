
import 'package:frontend/data-access/services/MaintenanceService.dart';

import '../../models/Dto/CreateMaintenanceDto.dart';
import '../../models/Dto/GetAllMaintenanceDto.dart';
import '../../models/Dto/UpdateMaintenanceDto.dart';
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

  Future<void> createMaintenanceReport(String token, CreateMaintenanceDto dto) async {
    await _maintenanceService.createMaintenanceReport(token, dto);
  }

  Future<void> updateMaintenanceReport(String token, int reportId, UpdateMaintenanceDto dto) async {
    await _maintenanceService.updateMaintenanceReport(token, reportId, dto);
  }

  Future<void> deleteReport(String token, int maintenanceId) async {
    final response = await _maintenanceService.deleteMaintenance(token, maintenanceId);
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete session');
    }
  }
}