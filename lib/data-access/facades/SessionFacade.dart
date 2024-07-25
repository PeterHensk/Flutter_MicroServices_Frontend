import 'package:http/http.dart';

import '../../models/Dto/CreateCarDto.dart';
import '../../models/Dto/GetAllSessionsDto.dart';
import '../../models/Dto/GetAllUsersDto.dart';
import '../../models/Dto/RunningSessionDto.dart';
import '../../models/Dto/StartSessionDto.dart';
import '../services/SessionService.dart';
import 'PageResponse.dart';

class SessionFacade {
  final SessionService _sessionService;

  SessionFacade(this._sessionService);

  Future<PageResponse<GetAllUsersDto>> getAllUsers(
      int pageIndex, int pageSize) async {
    try {
      final PageResponse<GetAllUsersDto> response =
          await _sessionService.getAllUsers(pageIndex, pageSize);
      return response;
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }

  Future<PageResponse<GetAllSessionsDto>> getAllSessions(
      String token, int pageIndex, int pageSize) async {
    try {
      final PageResponse<GetAllSessionsDto> response =
          await _sessionService.getAllSessions(token, pageIndex, pageSize);
      return response;
    } catch (error) {
      throw Exception('Failed to fetch sessions: $error');
    }
  }

  Future<void> deleteSession(String token, int sessionId) async {
    final response = await _sessionService.deleteSession(token, sessionId);
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete session');
    }
  }

  Future<Response> startSession(String token, StartSessionDto sessionDto) async {
    final response = await _sessionService.startSession(token, sessionDto);
    if (response.statusCode == 201 || response.statusCode == 404) {
      return response;
    } else {
      throw Exception('Failed to start session with status code: ${response.statusCode}');
    }
  }

  Future<RunningSessionDto?> getRunningSession(String token) async {
    try {
      final RunningSessionDto? session =
          await _sessionService.getRunningSession(token);
      return session;
    } catch (error) {
      throw Exception('Failed to fetch running session: $error');
    }
  }

  Future<void> stopSession(String token, int sessionId) async {
    try {
      await _sessionService.stopSession(token, sessionId);
    } catch (error) {
      throw Exception('Failed to stop session: $error');
    }
  }

  Future<Response> createCar(String token, CreateCarDto carDto) async {
    return await _sessionService.createCar(token, carDto);
  }
}
