import '../../models/Dto/GetAllSessionsDto.dart';
import '../../models/Dto/GetAllUsersDto.dart';
import '../services/SessionService.dart';
import 'PageResponse.dart';

class SessionFacade {
  final SessionService _sessionService;

  SessionFacade(this._sessionService);

  Future<PageResponse<GetAllUsersDto>> getAllUsers(int pageIndex, int pageSize) async {
    try {
      final PageResponse<GetAllUsersDto> response = await _sessionService.getAllUsers(pageIndex, pageSize);
      return response;
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }

  Future<PageResponse<GetAllSessionsDto>> getAllSessions(int pageIndex, int pageSize) async {
    try {
      final PageResponse<GetAllSessionsDto> response = await _sessionService.getAllSessions(pageIndex, pageSize);
      return response;
    } catch (error) {
      throw Exception('Failed to fetch sessions: $error');
    }
  }
}
