import 'package:flutter/material.dart';
import '../../models/Dto/GetAllStationsDto.dart';
import '../data-access/facades/PageResponse.dart';
import '../data-access/facades/StationFacade.dart';
import '../data-access/services/StationService.dart';
import '../widgets/general/NavBar.dart';
import '../widgets/general/PaginationWidget.dart';
import '../widgets/station/StationTile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: Text(AppLocalizations.of(context)!.station_screen_title),
      ),
      drawer: NavBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text((AppLocalizations.of(context)!.station_screen_intro),
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder<PageResponse<GetAllStationsDto>>(
              future: _futurePageResponse,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
                      PaginationWidget(
                        currentPage: _currentPage,
                        totalPages: pageResponse.totalPages,
                        onNextPage: _nextPage,
                        onPreviousPage: _previousPage,
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('No data available.'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text((AppLocalizations.of(context)!.station_screen_bottom),
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
