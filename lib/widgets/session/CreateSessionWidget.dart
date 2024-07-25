import 'package:flutter/material.dart';
import 'package:frontend/widgets/general/ThemeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:frontend/data-access/facades/SessionFacade.dart';
import 'package:frontend/models/Dto/StartSessionDto.dart';
import 'package:frontend/widgets/session/CreateCarDialog.dart';

class CreateSessionWidget extends StatelessWidget {
  final String stationIdentifier;
  final String portIdentifier;
  final VoidCallback onSessionCreated;

  const CreateSessionWidget({
    super.key,
    required this.stationIdentifier,
    required this.portIdentifier,
    required this.onSessionCreated,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showDialog(context);
      },
      child: Text('Start Session'),
    );
  }

  void _showDialog(BuildContext context) {
    final sessionFacade = Provider.of<SessionFacade>(context, listen: false);
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    final TextEditingController licensePlateController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start Session'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: licensePlateController,
                decoration: const InputDecoration(
                  labelText: 'Enter your license plate',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Start'),
              onPressed: () async {
                final String licensePlate = licensePlateController.text.trim();
                if (licensePlate.isNotEmpty) {
                  final token = themeNotifier.token;
                  if (token != null) {
                    final sessionDto = StartSessionDto(
                      licensePlate: licensePlate,
                      stationIdentifier: stationIdentifier,
                      portIdentifier: portIdentifier,
                    );

                    final response =
                        await sessionFacade.startSession(token, sessionDto);
                    if (response.statusCode == 201) {
                      Navigator.of(context).pop();
                      onSessionCreated();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Session started successfully!')),
                      );
                    } else if (response.statusCode == 404) {
                      Navigator.of(context).pop();
                      _showCreateCarDialog(
                          context, token, licensePlate, sessionDto);
                    } else {
                      print('Error starting session: ${response.body}');
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Failed to start session: ${response.body}')),
                      );
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('License plate cannot be empty')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showCreateCarDialog(BuildContext context, String token,
      String licensePlate, StartSessionDto sessionDto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateCarDialog(
          token: token,
          licensePlate: licensePlate,
          sessionDto: sessionDto,
          onSessionCreated: onSessionCreated,
        );
      },
    );
  }
}
