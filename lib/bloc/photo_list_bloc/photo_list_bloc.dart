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

  PhotoListBloc(this.photoRepository) : super(PhotoListInitial());

  @override
  Stream<PhotoListState> mapEventToState(
    PhotoListEvent event,
  ) async* {
    final currentState = state;
    if (event is AddPic) {
      try {
        if (currentState is PhotoListInitial) {
          final photos = await photoRepository.getPhotos(0);
          yield PhotoListLoaded(photos, 0);
        } else if (currentState is PhotoListLoaded) {
          int currentPage = currentState.page;
          final photos =
          await photoRepository.getPhotos(currentPage++);
          print("current_page = $currentPage");
          yield photos.isEmpty
              ? currentState.copyWith(photos)
              : PhotoListLoaded(currentState.photos + photos, currentPage);
        }
      } catch (error, stacktrace) {
        yield PhotoListError();
        print(error);
        print(stacktrace);
      }
    }


  }
}
