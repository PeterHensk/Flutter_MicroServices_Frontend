import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data-access/facades/SessionFacade.dart';
import '../../data-access/services/SessionService.dart';
import '../../models/Dto/GetAllSessionsDto.dart';
import '../../data-access/facades/PageResponse.dart';
import '../general/ConfirmDeleteDialog.dart';
import '../general/HoverMenuWidget.dart';
import '../general/PaginationWidget.dart';

class SessionTile extends StatefulWidget {
  final String token;

  const SessionTile({super.key, required this.token});

  @override
  _SessionTileState createState() => _SessionTileState();
}

class _SessionTileState extends State<SessionTile> {
  final SessionFacade _sessionFacade = SessionFacade(SessionService());
  Future<PageResponse<GetAllSessionsDto>>? _futureSessions;
  int _currentPage = 0;
  int _totalPages = 0;
  final int _pageSize = 6;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  void _loadSessions() async {
    setState(() {
      _futureSessions = _sessionFacade.getAllSessions(widget.token, _currentPage, _pageSize);
    });
    _futureSessions!.then((pageResponse) {
      setState(() {
        _totalPages = (pageResponse.totalElements / _pageSize).ceil();
      });
    });
  }

  void _deleteSession(int sessionId) async {
    try {
      await _sessionFacade.deleteSession(widget.token, sessionId);
      print("Session with ID: $sessionId deleted successfully");
    } catch (e) {
      print("Failed to delete session with ID: $sessionId. Error: $e");
    }
    _loadSessions();
  }

  void _editSession(int sessionId) {
    print("Editing session with ID: $sessionId");
    // Add your edit session logic here
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      setState(() {
        _currentPage++;
        _loadSessions();
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _loadSessions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PageResponse<GetAllSessionsDto>>(
      future: _futureSessions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final sessions = snapshot.data!.content;
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      final session = sessions[index];
                      final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
                      final startedFormatted = dateFormat.format(DateTime.parse(session.started));
                      final endedFormatted = dateFormat.format(DateTime.parse(session.ended));

                      return Center( // Center the ListTile
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ListTile(
                            title: Center(child: Text(session.stationIdentifier)),
                            subtitle: HoverMenuWidget(
                              actions: const [HoverMenuAction.edit, HoverMenuAction.delete],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          const TextSpan(text: 'Start: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: '$startedFormatted '),
                                          const TextSpan(text: 'Stop: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: endedFormatted),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(child: Text('${session.car.licensePlate} - ${session.car.brand}')),
                                  Center(child: Text('kWh charged: ${session.kwh.toStringAsFixed(2)}')),
                                ],
                              ),
                              onEdit: () => _editSession(session.id),
                                onDelete: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ConfirmDeleteDialog(
                                        onConfirm: () => _deleteSession(session.id),
                                      );
                                    },
                                  );
                                },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                PaginationWidget(
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  onNextPage: _nextPage,
                  onPreviousPage: _previousPage,
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('No sessions found'));
        }
      },
    );
  }
}
