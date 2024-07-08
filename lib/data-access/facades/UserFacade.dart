import '../../models/Dto/GetAllUsersDto.dart';
import '../services/SessionService.dart';
import 'PageResponse.dart';

class UserFacade {
  final SessionService _userService;

  UserFacade(this._userService);

  Future<PageResponse<GetAllUsersDto>> getAllUsers(int pageIndex, int pageSize) async {
    try {
      final PageResponse<GetAllUsersDto> response = await _userService.getAllUsers(pageIndex, pageSize);
      return response;
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }
}
