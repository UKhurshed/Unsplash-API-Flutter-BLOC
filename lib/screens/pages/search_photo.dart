
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pic_load/bloc/photo_list_bloc/search_list_bloc/search_list_bloc.dart';
import 'package:pic_load/model/search_photos.dart';
import 'package:pic_load/repository/search_photo_repository.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchPhoto extends StatelessWidget {
  final SearchPhotoRepository repository;

  const SearchPhoto({this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: SearchPhoto(),
      create: (context) => SearchListBloc(searchPhotoRepository: repository),
    );
  }
}

class SearchPhotos extends StatelessWidget {
  SearchPhotoRepositoryImpl searchPhotoRepositoryImpl;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SearchListBloc(searchPhotoRepository: searchPhotoRepositoryImpl),
      child: BlocBuilder<SearchListBloc, PhotoSearchState>(
        builder: (context, state) {
          if (state is SearchError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ));
          }
          if (state is SearchStateLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchStateSuccess) {
            return state.photos.isEmpty
                ? Text('Empty')
                : Expanded(
              child: _PhotoSearchResults(
                photoList: state.photos,
              ),
            );
          } else {
            return Text('else');
          }
        },
      ),
    );
  }
}

class _PhotoSearchResults extends StatelessWidget {
  final List<SearchPhotoList> photoList;

  _PhotoSearchResults({this.photoList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: photoList.length,
        itemBuilder: (context, index) {
          SearchPhotoList item;
          double displayWidth = MediaQuery.of(context).size.width;
          double finalHeight =
              displayWidth / (item.results.width / item.results.height);
          return InkWell(
            child: Hero(
              tag: 'photo${item.results.id}',
              child: Stack(
                children: [
                  SizedBox(
                    width: displayWidth,
                    height: 5,
                  ),
              ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: item.results.urls.regular,
                      fit: BoxFit.fitWidth,
                      height: finalHeight,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

// class _PhotoSearchResultItem extends StatelessWidget {
//   SearchPhotoList
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


