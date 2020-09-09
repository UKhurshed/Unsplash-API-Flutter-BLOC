part of 'photo_list_bloc.dart';

@immutable
abstract class PhotoListState {
  const PhotoListState();
}

class PhotoListInitial extends PhotoListState {
  const PhotoListInitial();
}

class PhotoListError extends PhotoListState{
  const PhotoListError();
}

class PhotoListLoaded extends PhotoListState{
  final List<PhotoListBean> photos;
  final int page;

  PhotoListLoaded(this.photos, this.page);

  PhotoListLoaded copyWith(List<PhotoListBean> photos) {
    return PhotoListLoaded(photos, page);
  }
}

