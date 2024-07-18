import '../../models/Dto/GetAllSessionsDto.dart';
import '../../models/Dto/GetAllUsersDto.dart';
import '../../models/Dto/RunningSessionDto.dart';
import '../../models/Dto/StartSessionDto.dart';
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

  Future<void> deleteSession(int sessionId) async {
    final response = await _sessionService.deleteSession(sessionId);
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete session');
    }
  }

  Future<void> startSession(String token, StartSessionDto sessionDto) async {
    try {
      final response = await _sessionService.startSession(token, sessionDto);
      if (response.statusCode != 201) {
        throw Exception('Failed to start session');
      }
    } catch (error) {
      throw Exception('Failed to start session: $error');
    }
  }

  Future<RunningSessionDto?> getRunningSession(String token) async {
    try {
      final RunningSessionDto? session = await _sessionService.getRunningSession(token);
      return session;
    } catch (error) {
      throw Exception('Failed to fetch running session: $error');
    }
  }
}
