import 'package:flutter/material.dart';
import 'package:frontend/data-access/facades/SessionFacade.dart';
import 'package:frontend/models/Dto/CreateCarDto.dart';
import 'package:frontend/models/Dto/StartSessionDto.dart';
import 'package:provider/provider.dart';

class CreateCarDialog extends StatefulWidget {
  final String token;
  final String licensePlate;
  final StartSessionDto sessionDto;

  const CreateCarDialog({
    Key? key,
    required this.token,
    required this.licensePlate,
    required this.sessionDto,
  }) : super(key: key);

  @override
  _CreateCarDialogState createState() => _CreateCarDialogState();
}

class _CreateCarDialogState extends State<CreateCarDialog> {
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Car'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _brandController,
            decoration: InputDecoration(labelText: 'Car Brand'),
          ),
          TextField(
            controller: _modelController,
            decoration: InputDecoration(labelText: 'Car Model'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Create and Start Session'),
          onPressed: () async => _createCarAndStartSession(context),
        ),
      ],
    );
  }

  Future<void> _createCarAndStartSession(BuildContext context) async {
    final sessionFacade = Provider.of<SessionFacade>(context, listen: false);
    final CreateCarDto carDto = CreateCarDto(
      brand: _brandController.text.trim(),
      model: _modelController.text.trim(),
      licensePlate: widget.licensePlate,
    );

    try {
      await sessionFacade.createCar(widget.token, carDto);
      await sessionFacade.startSession(widget.token, widget.sessionDto);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Car created and session started successfully!')),
      );
    } catch (error) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create car or start session: ${error.toString()}')),
      );
    }
  }
}