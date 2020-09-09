import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pic_load/model/item_picture.dart';
import 'package:pic_load/repository/photo_repository.dart';

part 'photo_list_event.dart';

part 'photo_list_state.dart';

class PhotoListBloc extends Bloc<PhotoListEvent, PhotoListState> {
  final PhotoRepository photoRepository;
  int _page = 0;

  PhotoListBloc(this.photoRepository) : super(PhotoListInitial());

  @override
  Stream<PhotoListState> mapEventToState(
    PhotoListEvent event,
  ) async* {
    if (event is GetInitialPhotos) {
      yield PhotoListInitial();
      for (int _i = 0; _i < 7; _i++) {
        _page = _i;
        final photos = await photoRepository.getPhotos(_page);
        yield PhotoListLoaded(photos, _page);
      }
    }
    if (event is AddPic) {
      final photos = await photoRepository.getPhotos(++_page);
      yield PhotoListLoaded(photos, _page);
    }

  }
}
