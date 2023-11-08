import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Navegar a la pantalla de registro después del cierre de sesión
    Navigator.of(context).pushReplacementNamed('/register'); // Asegúrate de tener una ruta llamada '/registerScreen' en tu MaterialApp
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Perfil de Usuario')),
        body: const Center(child: Text('No hay un usuario autenticado. Inicie sesión.')),
      );
    }

    // Acceso a la instancia de Firestore
    final firestore = FirebaseFirestore.instance;

    // Crear una función para obtener el nombre de usuario desde Firestore
    Future<String> getUsername(String uid) async {
      try {
        var userData = await firestore.collection('users').doc(uid).get();
        return userData.data()?['username'] ?? 'Nombre de usuario no disponible';
      } catch (e) {
        return 'Error al obtener el nombre de usuario';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL ?? 'https://via.placeholder.com/150'),
          ),
          const SizedBox(width: 16), 
        ],
      ),
      body: FutureBuilder(
        future: getUsername(user.uid),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          String username = snapshot.data ?? 'No disponible';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Nombre de usuario: $username', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Correo electrónico: ${user.email ?? 'Correo no disponible'}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => signOut(context),
                  child: const Text('Cerrar sesión'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Color del botón
                    onPrimary: Colors.white, // Color del texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
