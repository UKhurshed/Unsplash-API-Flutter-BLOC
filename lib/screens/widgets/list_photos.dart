import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pic_load/bloc/photo_list_bloc/photo_list_bloc.dart';
import 'package:pic_load/model/item_picture.dart';
import 'package:pic_load/repository/photo_repository.dart';
import 'package:pic_load/screens/pages/details_screen.dart';
import 'package:pic_load/screens/widgets/bottomLoader.dart';
import 'package:transparent_image/transparent_image.dart';

class ListPhoto extends StatelessWidget {
  final PhotoRepository repository;

  const ListPhoto(this.repository);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: _ListPhoto(),
      create: (context) => PhotoListBloc(repository),
    );
  }
}

class _ListPhoto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => __ListPhotoState();
}

class __ListPhotoState extends State<_ListPhoto> {
  PhotoListBloc _photoListBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _photoListBloc = BlocProvider.of<PhotoListBloc>(context);
    _photoListBloc.add(AddPic());
    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _photoListBloc.add(AddPic());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoListBloc, PhotoListState>(
        builder: (buildContext, state) {
      if (state is PhotoListError) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Error'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      }
      if (state is PhotoListInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is PhotoListLoaded) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.photos.length + 1,
            controller: _scrollController,
            itemBuilder: (buildContext, index) {
              if (index >= state.photos.length) return BottomLoader();
              PhotoListBean item = state.photos[index];
              double displayWidth = MediaQuery.of(context).size.width;
              double finalHeight = displayWidth / (item.width / item.height);

              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: InkWell(
                  onTap: () => _onPhotoTap(item),
                  child: Hero(
                    tag: 'photo${item.id}',
                    child: Stack(
                      children: [
                        SizedBox(
                          width: displayWidth,
                          height: 5,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage.memoryNetwork(
                            image: item.urls.thumb,
                            placeholder: kTransparentImage,
                            fit: BoxFit.fitWidth,
                            width: displayWidth,
                            height: finalHeight,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage.memoryNetwork(
                            image: item.urls.regular,
                            placeholder: kTransparentImage,
                            fit: BoxFit.fitWidth,
                            width: displayWidth,
                            height: finalHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }
      return Center(child: Text("YEP"));
    });
  }

  _onPhotoTap(PhotoListBean photoListBean) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsPage(),
            settings: RouteSettings(
                arguments: PhotoDetailPageArguments(photoListBean))));
  }
}
