import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/lost_item_model.dart';
import 'bloc/lost_item_bloc.dart';
import 'bloc/lost_item_event.dart';
import 'bloc/lost_item_state.dart';
import 'package:image_picker/image_picker.dart';

class LostItemForm extends StatefulWidget {
  const LostItemForm({Key? key}) : super(key: key);

  @override
  State<LostItemForm> createState() => _LostItemFormState();
}

class _LostItemFormState extends State<LostItemForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _location = '';
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    final lostItemBloc = BlocProvider.of<LostItemBloc>(context);
    InputDecoration textFieldDecoration(String hint) => InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
              color: Colors.grey), 
          fillColor: const Color(0xFFECDFE4),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
        
        );

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromRGBO(129, 40, 75, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Objetos Perdidos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: BlocConsumer<LostItemBloc, LostItemState>(
            listener: (context, state) {
              if (state is LostItemSubmitSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Objeto Reportado')),
                );
                _formKey.currentState?.reset();
              } else if (state is LostItemSubmitFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: textFieldDecoration('Nombre del objeto'),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Este campo es obligatorio'
                            : null,
                        onSaved: (value) => _title = value!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: textFieldDecoration('Descripción'),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Este campo es obligatorio'
                            : null,
                        onSaved: (value) => _description = value!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: textFieldDecoration('Lugar'),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Este campo es obligatorio'
                            : null,
                        onSaved: (value) => _location = value!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: textFieldDecoration('Número de teléfono'),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Este campo es obligatorio'
                            : null,
                        onSaved: (value) => _phoneNumber = value!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.camera),
                            label: const Text('Cámara'),
                            style: buttonStyle,
                            onPressed: () => lostItemBloc
                                .add(PickImageEvent(ImageSource.camera)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.photo_library),
                              label: const Text('Galería'),
                              style: buttonStyle,
                              onPressed: () => lostItemBloc
                                  .add(PickImageEvent(ImageSource.gallery)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        onPressed: state is LostItemSubmittingState
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  lostItemBloc.add(SubmitLostItemEvent(
                                    LostItem(
                                      name: _title,
                                      description: _description,
                                      location: _location,
                                      phone: _phoneNumber,
                                    ),
                                  ));
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromRGBO(129, 40, 75, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state is LostItemSubmittingState
                            ? const CircularProgressIndicator()
                            : const Text('REPORTAR OBJETO',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
