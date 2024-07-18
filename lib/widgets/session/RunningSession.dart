import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/Dto/RunningSessionDto.dart';

class RunningSession extends StatelessWidget {
  final RunningSessionDto? session;

  const RunningSession({Key? key, this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final startedFormatted = dateFormat.format(DateTime.parse(session!.started));
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400], // Set background color to a bit darker grey
        borderRadius: BorderRadius.circular(8), // Round the corners
      ),
      child: ListTile(
        title: session != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session for',
              style: TextStyle(color: Colors.grey[900]), // Darker text color
            ),
            Text(
              session!.licensePlate,
              style: TextStyle(color: Colors.grey[900]), // Darker text color
            ),
          ],
        )
            : Text(
          'No running session',
          style: TextStyle(color: Colors.grey[900]), // Darker text color
        ),
        subtitle: session != null
            ? Text(
          'Started at: $startedFormatted',
          style: TextStyle(color: Colors.grey[900]), // Darker text color
        )
            : null,
        trailing: session != null
            ? ElevatedButton(
          onPressed: () {},
          child: const Text('Stop session'),
        )
            : null, // Do not display the button if there is no running session
      ),
    );
  }
}