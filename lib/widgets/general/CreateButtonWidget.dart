import 'package:flutter/material.dart';
import 'package:frontend/widgets/general/ThemeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:frontend/data-access/facades/SessionFacade.dart';
import 'package:frontend/models/Dto/StartSessionDto.dart';

class CreateButtonWidget extends StatelessWidget {
  final String stationIdentifier;
  final String portIdentifier;

  CreateButtonWidget({required this.stationIdentifier, required this.portIdentifier});

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
    final TextEditingController licensePlateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start Session'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Station Identifier: $stationIdentifier'),
              Text('Port Identifier: $portIdentifier'),
              TextField(
                controller: licensePlateController,
                decoration: InputDecoration(
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

                    try {
                      // Attempt to start the session
                      await sessionFacade.startSession(token, sessionDto);
                      Navigator.of(context).pop(); // Close the dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Session started successfully!')),
                      );
                    } catch (error) {
                      // Log detailed error information
                      print('Error starting session: $error');
                      Navigator.of(context).pop(); // Close the dialog first
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to start session: ${error.toString()}')),
                      );
                    }
                  } else {
                    Navigator.of(context).pop(); // Close the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Authentication token is missing')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('License plate cannot be empty')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
