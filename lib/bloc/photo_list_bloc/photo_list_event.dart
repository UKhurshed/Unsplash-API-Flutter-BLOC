part of 'photo_list_bloc.dart';

@immutable
abstract class PhotoListEvent{
  const PhotoListEvent();
}

class AddPic extends PhotoListEvent{
  const AddPic();
}
