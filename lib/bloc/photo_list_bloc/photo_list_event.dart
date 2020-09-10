part of 'photo_list_bloc.dart';

@immutable
abstract class PhotoListEvent extends Equatable {
  const PhotoListEvent();

  @override
  List<Object> get props => [];
}

class AddPic extends PhotoListEvent{
  const AddPic();
}
