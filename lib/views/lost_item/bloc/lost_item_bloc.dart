import 'package:bloc/bloc.dart';
import '../controller/lost_item_controller.dart';
import 'lost_item_event.dart';
import 'lost_item_state.dart';

class LostItemBloc extends Bloc<LostItemEvent, LostItemState> {
  final LostItemFormController _controller;

  LostItemBloc(this._controller) : super(LostItemInitialState()) {
    on<PickImageEvent>((event, emit) async {
      try {
        final imageFile = await _controller.getImage(event.source);
        if (imageFile != null) {
          emit(LostItemImagePickedState(imageFile.path));
        } else {
          emit(LostItemSubmitFailedState('No se seleccionó ninguna imagen.'));
        }
      } catch (e) {
        emit(LostItemSubmitFailedState(e.toString()));
      }
    });

    on<SubmitLostItemEvent>((event, emit) async {
      try {
        emit(LostItemSubmittingState());

        // Sube la imagen primero si existe
        String? imageUrl;
        if (_controller.image != null) {
          imageUrl = await _controller.uploadImageToFirebase();
        }

        // Guarda el objeto perdido en Firestore
        await _controller.saveLostItemToFirestore(
          title: event.lostItem.name,
          description: event.lostItem.description,
          location: event.lostItem.location,
          imageUrl: imageUrl,
          phone: '+591${event.lostItem.phone}',
        );

        emit(LostItemSubmitSuccessState());
      } catch (e) {
        emit(LostItemSubmitFailedState(e.toString()));
      }
    });
  }
}
