import 'package:flutter/material.dart';
import 'package:frontend/data-access/services/MaintenanceService.dart';
import '../data-access/facades/MaintenanceFacade.dart';
import '../data-access/facades/SessionFacade.dart';
import '../models/Dto/GetAllMaintenanceDto.dart';
import '../data-access/facades/PageResponse.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/general/NavBar.dart';
import '../widgets/general/PaginationWidget.dart';
import '../widgets/maintenance/MaintenanceTile.dart';

class MaintenancePage extends StatefulWidget {
  final String token;
  final SessionFacade sessionFacade;
  final MaintenanceFacade maintenanceFacade;

  static final maintenancePageKey = GlobalKey<MaintenancePageState>();

  MaintenancePage({
    required this.token,
    required this.maintenanceFacade,
    required this.sessionFacade,
    Key? key,
  }) : super(key: maintenancePageKey);

  @override
  MaintenancePageState createState() => MaintenancePageState();
}

class MaintenancePageState extends State<MaintenancePage> {
  final MaintenanceFacade _maintenanceFacade = MaintenanceFacade(MaintenanceService());
  int _currentPage = 0;
  final int _pageSize = 5;
  Future<PageResponse<GetAllMaintenanceDto>>? _futurePageResponse;

  @override
  void initState() {
    super.initState();
    _loadMaintenanceReports();
  }

  void _loadMaintenanceReports() {
    setState(() {
      _futurePageResponse = _maintenanceFacade.getMaintenanceReports(widget.token, _currentPage, _pageSize);
    });
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
      _loadMaintenanceReports();
    });
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _loadMaintenanceReports();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.maintenance_screen_title),
      ),
      drawer: NavBar(sessionFacade: widget.sessionFacade, maintenanceFacade: widget.maintenanceFacade),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(AppLocalizations.of(context)!.maintenance_screen_intro,
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder<PageResponse<GetAllMaintenanceDto>>(
              future: _futurePageResponse,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final pageResponse = snapshot.data!;
                  final reports = pageResponse.content;

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: reports.length,
                          itemBuilder: (context, index) {
                            return MaintenanceTile(
                                maintenanceReport: reports[index],
                                token: widget.token,
                                maintenanceFacade: widget.maintenanceFacade,
                                onMaintenanceDeleted: _loadMaintenanceReports,
                              );
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
        ],
      ),
    );
  }
}