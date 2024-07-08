import 'package:flutter/material.dart';
import '../../models/Dto/GetAllStationsDto.dart';
import '../data-access/facades/PageResponse.dart';
import '../data-access/facades/StationFacade.dart';
import '../data-access/services/StationService.dart';
import '../widgets/NavBar.dart';
import '../widgets/StationTile.dart';

class StationManagement extends StatefulWidget {
  @override
  _StationManagementState createState() => _StationManagementState();
}

class _StationManagementState extends State<StationManagement> {
  final StationFacade _stationFacade = StationFacade(StationService());
  Future<PageResponse<GetAllStationsDto>>? _futurePageResponse;
  int _currentPage = 0;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  void _loadStations() {
    setState(() {
      _futurePageResponse = _stationFacade.getAllStations(_currentPage, _pageSize);
    });
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
      _loadStations();
    });
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _loadStations();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Station Management'),
      ),
      drawer: NavBar(),
      body: FutureBuilder<PageResponse<GetAllStationsDto>>(
        future: _futurePageResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final pageResponse = snapshot.data!;
            final stations = pageResponse.content;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: stations.length,
                    itemBuilder: (context, index) {
                      return StationTile(station: stations[index]);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _previousPage,
                      child: Text('Previous'),
                    ),
                    Text('Page ${_currentPage + 1}'),
                    TextButton(
                      onPressed: pageResponse.pageNumber < pageResponse.totalPages - 1 ? _nextPage : null,
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
