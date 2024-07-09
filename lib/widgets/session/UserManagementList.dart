import 'package:flutter/material.dart';
import '../../../models/Dto/GetAllUsersDto.dart';
import '../../data-access/facades/PageResponse.dart';
import '../../data-access/services/SessionService.dart';
import '../general/PaginationWidget.dart';
import '../general/EditableCell.dart';

class UserManagementList extends StatefulWidget {
  Future<PageResponse<GetAllUsersDto>>? futurePageResponse;
  final int currentPage;
  final int totalPages;
  final int pageNumber;
  final int totalElements;
  final Function onNextPage;
  final Function onPreviousPage;

  UserManagementList({
    required this.futurePageResponse,
    required this.currentPage,
    required this.totalPages,
    required this.pageNumber,
    required this.totalElements,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  _UserManagementListState createState() => _UserManagementListState();
}

class _UserManagementListState extends State<UserManagementList> {
  final _userService = SessionService();
  Future<PageResponse<GetAllUsersDto>>? futurePageResponse;
  int _currentPage = 0;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    futurePageResponse =
        _userService.getAllUsers(widget.currentPage, widget.totalElements);
  }

  void _reloadData() {
    setState(() {
      futurePageResponse = _userService.getAllUsers(
          widget.currentPage,
          widget.totalElements);
    });
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
      _reloadData();
    });
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _reloadData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PageResponse<GetAllUsersDto>>(
      future: widget.futurePageResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final pageResponse = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: DataTable(
                  dataRowMaxHeight: 48.0,
                  columns: const [
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('First Name')),
                    DataColumn(label: Text('Last Name')),
                    DataColumn(label: Text('Role')),
                  ],
                  rows: pageResponse.content.asMap().entries.map((entry) {
                    final user = entry.value;
                    return DataRow(
                      cells: [
                        DataCell(EditableCell(
                          initialValue: user.email,
                          onSubmitted: (value) {
                            _userService.updateUserField(user, 'email', value);
                          },
                        )),
                        DataCell(EditableCell(
                          initialValue: user.firstName,
                          onSubmitted: (value) {
                            _userService.updateUserField(
                                user, 'firstName', value);
                          },
                        )),
                        DataCell(EditableCell(
                          initialValue: user.lastName,
                          onSubmitted: (value) {
                            _userService.updateUserField(
                                user, 'lastName', value);
                          },
                        )),
                        DataCell(EditableCell(
                          initialValue: user.role,
                          onSubmitted: (value) {
                            _userService.updateUserField(user, 'role', value);
                          },
                          isDropdown: true,
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
              PaginationWidget(
                currentPage: _currentPage,
                totalPages: pageResponse.totalPages,
                onNextPage: _nextPage,
                onPreviousPage: _previousPage,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('Total Records: ${pageResponse.totalElements}'),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('No users found'));
        }
      },
    );
  }
}
