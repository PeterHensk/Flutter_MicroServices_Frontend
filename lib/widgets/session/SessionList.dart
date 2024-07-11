import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data-access/services/SessionService.dart';
import '../../models/Dto/GetAllSessionsDto.dart';
import '../../data-access/facades/PageResponse.dart';
import '../general/PaginationWidget.dart';

class SessionList extends StatefulWidget {
  @override
  _SessionListState createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  final SessionService _sessionService = SessionService();
  Future<PageResponse<GetAllSessionsDto>>? _futureSessions;
  int _currentPage = 0;
  int _totalPages = 0;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  void _loadSessions() async {
    setState(() {
      _futureSessions = _sessionService.getAllSessions(_currentPage, _pageSize);
    });
    _futureSessions!.then((pageResponse) {
      setState(() {
        _totalPages = (pageResponse.totalElements / _pageSize).ceil();
      });
    });
  }

  void _deleteSession(int sessionId) {
    print("Deleting session with ID: $sessionId");
    _loadSessions();
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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
                    final startedFormatted = dateFormat.format(DateTime.parse(session.started));
                    final endedFormatted = dateFormat.format(DateTime.parse(session.ended));

                    return ListTile(
                      title: Text('${session.stationIdentifier}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$startedFormatted\n$endedFormatted'),
                          Text('${session.car.licensePlate} - ${session.car.brand}'),
                          Text('kWh charged: ${session.kwh.toStringAsFixed(2)}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteSession(session.id);
                        },
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
          );
        } else {
          return Center(child: Text('No sessions found'));
        }
      },
    );
  }
}