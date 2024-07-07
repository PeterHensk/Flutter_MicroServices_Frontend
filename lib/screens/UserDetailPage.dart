import 'package:flutter/material.dart';
import '../models/Dto/GetAllUsersDto.dart';

class UserDetailPage extends StatelessWidget {
  final GetAllUsersDto user;

  UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user.email}'),
            Text('First Name: ${user.firstName}'),
            Text('Last Name: ${user.lastName}'),
            Text('Updated: ${user.updated.toString()}'),
            Text('Role: ${user.role}'),
          ],
        ),
      ),
    );
  }
}