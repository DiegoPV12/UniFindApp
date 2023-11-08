import 'package:flutter/material.dart';


class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Usuario'),
      ),
      body: const Center(
        child: Text('Aquí van los detalles del usuario.'),
      ),
    );
  }
}
