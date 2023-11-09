import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unifind/views/lost_item/controller/lost_item_controller.dart';
import 'package:unifind/views/lost_item/lost_item_page.dart';
import '../../models/lost_item_model.dart';
import '../../widgets/lost_item_card.dart';
import '../lost_item/bloc/lost_item_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LostItem> items = [];
  final LostItemFormController _repository = LostItemFormController();

  String?
      currentUserEmail; // Esto ahora es nullable para manejar casos donde el usuario no esté autenticado.

  @override
  void initState() {
    super.initState();
    _loadLostItems();
    _getCurrentUserEmail(); // Obtener el email del usuario actual al iniciar
  }

  void _getCurrentUserEmail() {
    // Establece el email del usuario actual de Firebase
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserEmail = user.email;
      });
    }
  }

  Stream<List<LostItem>> _loadLostItems() {
    return _repository.fetchLostItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) =>
                    LostItemBloc(_repository), // Asegúrate de que esto corresponde con la manera correcta de crear tu Bloc
                child: const LostItemForm(),
              ),
            ),
          );
        },
        backgroundColor: const Color.fromRGBO(129, 40, 75, 1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
          title: const Text('Objetos Reportados'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).pushNamed('/userProfile');
              },
            ),
          ]),
      body: StreamBuilder<List<LostItem>>(
        stream: _loadLostItems(),
        builder:
            (BuildContext context, AsyncSnapshot<List<LostItem>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No hay objetos perdidos reportados aún.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final item = snapshot.data![index];
              return LostItemCard(
                item: item,
                onTap: () {},
                currentUserEmail: currentUserEmail ?? '',
              );
            },
          );
        },
      ),
    );
  }
}
