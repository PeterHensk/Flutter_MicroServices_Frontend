import '../services/StationService.dart';
import '../../models/Dto/GetAllStationsDto.dart';
import 'PageResponse.dart';

class StationFacade {
  final StationService _stationService;

  StationFacade(this._stationService);

  Future<PageResponse<GetAllStationsDto>> getAllStations(String token, int pageIndex, int pageSize) async {
    try {
      final PageResponse<GetAllStationsDto> response = await _stationService.getAllStations(token, pageIndex, pageSize);
      return response;
    } catch (error) {
      throw Exception('Failed to fetch stations: $error');
    }
  }
}