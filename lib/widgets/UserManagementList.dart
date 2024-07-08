import 'package:flutter/material.dart';
import 'package:frontend/widgets/EditableCell.dart';
import '../../models/Dto/GetAllUsersDto.dart';
import '../data-access/facades/PageResponse.dart';
import '../data-access/services/SessionService.dart';
import '../models/Dto/UpdateUserDto.dart';
import '../screens/UserDetailPage.dart';

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

  @override
  void initState() {
    super.initState();
    futurePageResponse =
        _userService.getAllUsers(widget.currentPage, widget.totalElements);
  }

  Future<void> _updateUser(UpdateUserDto user, String field, String value) {
    UpdateUserDto updatedUser = UpdateUserDto(
      id: user.id,
      email: field == 'email' ? value : user.email,
      firstName: field == 'firstName' ? value : user.firstName,
      lastName: field == 'lastName' ? value : user.lastName,
      role: field == 'role' ? value : user.role,
      updated: DateTime.now(),
    );
    return _userService.updateUser(user.id, updatedUser).then((_) {
      _reloadData();
    });
  }

  void _reloadData() {
    setState(() {
      futurePageResponse = _userService.getAllUsers(
          widget.currentPage,
          widget.totalElements);
    });
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: widget.currentPage > 0
                                  ? () => widget.onPreviousPage()
                                  : null,
                              tooltip: 'Previous Page',
                            ),
                            Text(
                                'Page ${widget.pageNumber + 1} of ${pageResponse.totalPages}'),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: widget.currentPage <
                                      pageResponse.totalPages - 1
                                  ? () => widget.onNextPage()
                                  : null,
                              tooltip: 'Next Page',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            'Total Records: ${pageResponse.totalElements}'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('No users found'));
        }
      },
    );
  }
}
