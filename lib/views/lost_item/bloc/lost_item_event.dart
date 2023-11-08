  import 'package:image_picker/image_picker.dart';

  import '../../../models/lost_item_model.dart';

  abstract class LostItemEvent {}

  class PickImageEvent extends LostItemEvent {
    final ImageSource source;

    PickImageEvent(this.source);
  }

  class SubmitLostItemEvent extends LostItemEvent {
    final LostItem lostItem;

    SubmitLostItemEvent(this.lostItem);
  }
