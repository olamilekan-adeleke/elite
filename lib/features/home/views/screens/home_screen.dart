import 'package:elite/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Center(
        child: Container(
          child: InkWell(
            onTap: () => AuthenticationRepo().signOut(),
            child: Text('HomeScreen'),
          ),
        ),
      ),
    );
  }
}
