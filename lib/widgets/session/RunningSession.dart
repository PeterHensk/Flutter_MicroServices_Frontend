import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data-access/facades/SessionFacade.dart';
import '../../models/Dto/RunningSessionDto.dart';
import '../../screens/HomePage.dart';

class RunningSession extends StatelessWidget {
  final RunningSessionDto? session;
  final String token;
  final String firstName;
  final String lastName;
  final SessionFacade sessionFacade;

  const RunningSession({
    super.key,
    required this.token,
    required this.sessionFacade,
    this.session,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    if (session == null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            'No running session',
            style: TextStyle(color: Colors.grey[900]),
          ),
        ),
      );
    }

    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final startedFormatted =
        dateFormat.format(DateTime.parse(session!.started));
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session for ${session?.licensePlate}',
              style: TextStyle(color: Colors.grey[900]),
            ),
            Text(
              'Started at: $startedFormatted',
              style: TextStyle(color: Colors.grey[900]),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () async {
            try {
              await sessionFacade.stopSession(token, session!.id);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          sessionFacade: sessionFacade,
                          firstName: firstName,
                          lastName: lastName,
                        )),
              );
            } catch (e) {
              print('Error stopping session: $e');
            }
          },
          child: const Text('Stop session'),
        ),
      ),
    );
  }
}
