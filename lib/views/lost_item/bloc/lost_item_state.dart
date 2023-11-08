abstract class LostItemState {}

class LostItemInitialState extends LostItemState {}

class LostItemImagePickedState extends LostItemState {
  final String imagePath;

  LostItemImagePickedState(this.imagePath);
}

class LostItemSubmittingState extends LostItemState {}

class LostItemSubmitSuccessState extends LostItemState {}

class LostItemSubmitFailedState extends LostItemState {
  final String error;

  LostItemSubmitFailedState(this.error);
}
