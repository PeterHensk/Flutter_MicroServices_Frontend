import 'package:flutter/material.dart';
import '../../models/Dto/GetAllUsersDto.dart';
import '../data-access/facades/PageResponse.dart';
import '../data-access/facades/UserFacade.dart';
import '../data-access/services/UserService.dart';
import '../widgets/NavBar.dart';
import '../widgets/UserManagementList.dart';

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  final UserFacade _userFacade = UserFacade(UserService());
  Future<PageResponse<GetAllUsersDto>>? _futurePageResponse;
  int _currentPage = 0;
  final int _pageSize = 10;
  int _totalPages = 1;
  int _totalElements = 0;
  int _pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      _futurePageResponse = _userFacade.getAllUsers(_currentPage, _pageSize);
      _futurePageResponse?.then((pageResponse) {
        setState(() {
          _totalPages = pageResponse.totalPages;
          _totalElements = pageResponse.totalElements;
          _pageNumber = pageResponse.pageNumber;
        });
      });
    });
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
      _loadUsers();
    });
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _loadUsers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      drawer: NavBar(),
      body: UserManagementList(
        futurePageResponse: _futurePageResponse,
        currentPage: _currentPage,
        totalPages: _totalPages,
        pageNumber: _pageNumber,
        totalElements: _totalElements,
        onNextPage: _nextPage,
        onPreviousPage: _previousPage,
      ),
    );
  }
}
