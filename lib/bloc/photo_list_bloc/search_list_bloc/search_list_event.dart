part of 'search_list_bloc.dart';

@immutable
abstract class SearchListEvent {
  const SearchListEvent();
}

class GetSearchPhotos extends SearchListEvent {
  final String query;

  const GetSearchPhotos({@required this.query});
}
