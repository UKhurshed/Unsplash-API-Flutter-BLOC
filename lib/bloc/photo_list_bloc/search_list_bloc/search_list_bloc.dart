import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pic_load/model/search_photos.dart';
import 'package:pic_load/repository/search_photo_repository.dart';

part 'search_list_event.dart';

part 'search_list_state.dart';

class SearchListBloc extends Bloc<SearchListEvent, PhotoSearchState> {
  final SearchPhotoRepository searchPhotoRepository;

  SearchListBloc({@required this.searchPhotoRepository})
      : super(SearchStateLoading());

  @override
  Stream<PhotoSearchState> mapEventToState(
    SearchListEvent event,
  ) async* {
    // if (event is SearchListInitial) {
    //   yield SearchInitial();
    // }
    if (state is GetSearchPhotos) {
      yield* _mapPhotoSearch(event);
    }
  }

  Stream<PhotoSearchState> _mapPhotoSearch(GetSearchPhotos event) async* {
    final String searchQuery = event.query;
    try {
      yield SearchStateLoading();
      final result = await searchPhotoRepository.getPhotos(searchQuery);
      yield SearchStateSuccess(result, searchQuery);
    } catch (error) {
      yield error is SearchError
          ? SearchError(error.message)
          : SearchError("Error");
    }
  }
}
