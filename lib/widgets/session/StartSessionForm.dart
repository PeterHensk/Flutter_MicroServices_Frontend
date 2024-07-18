import 'package:flutter/material.dart';
import '../../data-access/facades/SessionFacade.dart';
import '../../models/Dto/StartSessionDto.dart';

class StartSessionForm extends StatefulWidget {
  final SessionFacade sessionFacade;
  final String token;

  const StartSessionForm({Key? key, required this.sessionFacade, required this.token}) : super(key: key);

  @override
  _StartSessionFormState createState() => _StartSessionFormState();
}

class _StartSessionFormState extends State<StartSessionForm> {
  final _formKey = GlobalKey<FormState>();
  String _licensePlate = '';
  String _stationIdentifier = '';
  String _portIdentifier = '';

  void _startSession() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final dto = StartSessionDto(
        licensePlate: _licensePlate,
        stationIdentifier: _stationIdentifier,
        portIdentifier: _portIdentifier,
      );
      widget.sessionFacade.startSession(widget.token, dto).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Session started successfully')));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to start session: $error')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'License Plate'),
            onSaved: (value) => _licensePlate = value!,
            validator: (value) => value!.isEmpty ? 'Please enter the license plate' : null,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Station Identifier'),
            onSaved: (value) => _stationIdentifier = value!,
            validator: (value) => value!.isEmpty ? 'Please enter the station identifier' : null,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Port Identifier'),
            onSaved: (value) => _portIdentifier = value!,
            validator: (value) => value!.isEmpty ? 'Please enter the port identifier' : null,
          ),
          ElevatedButton(
            onPressed: _startSession,
            child: Text('Start Session'),
          ),
        ],
      ),
    );
  }
}