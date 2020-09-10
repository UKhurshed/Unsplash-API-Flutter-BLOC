part of 'search_list_bloc.dart';

@immutable
abstract class PhotoSearchState {
  const PhotoSearchState();
}


// class SearchStateEmpty extends PhotoSearchState {
//   @override
//   String toString() => 'SearchStateEmpty';
// }

class SearchStateLoading extends PhotoSearchState {
}

class SearchStateSuccess extends PhotoSearchState {
  final List<SearchPhotoList> photos;
  final String query;

  SearchStateSuccess(this.photos, this.query);
}

class SearchError extends PhotoSearchState{
  final String message;
  const SearchError(this.message);

}
