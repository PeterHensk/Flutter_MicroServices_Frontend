import 'package:flutter/material.dart';
import 'package:frontend/data-access/facades/SessionFacade.dart';
import 'package:frontend/models/Dto/CreateCarDto.dart';
import 'package:frontend/models/Dto/StartSessionDto.dart';
import 'package:provider/provider.dart';

class CreateCarDialog extends StatefulWidget {
  final String token;
  final String licensePlate;
  final StartSessionDto sessionDto;
  final VoidCallback onSessionCreated;

  const CreateCarDialog({
    super.key,
    required this.token,
    required this.licensePlate,
    required this.sessionDto,
    required this.onSessionCreated,
  });

  @override
  _CreateCarDialogState createState() => _CreateCarDialogState();
}

class _CreateCarDialogState extends State<CreateCarDialog> {
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Car'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _brandController,
            decoration: const InputDecoration(labelText: 'Car Brand'),
          ),
          TextField(
            controller: _modelController,
            decoration: const InputDecoration(labelText: 'Car Model'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('Create and Start Session'),
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
      widget.onSessionCreated();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Car created and session started successfully!')),
      );
    } catch (error) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Failed to create car or start session: ${error.toString()}')),
      );
    }
  }
}
