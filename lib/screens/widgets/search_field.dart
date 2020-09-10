import 'package:flutter/material.dart';
import 'package:pic_load/bloc/photo_list_bloc/search_list_bloc/search_list_bloc.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchField();
}


class SearchField extends State<SearchBar> {

   final _photoSearchController = TextEditingController();
   SearchListBloc _searchListBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 243, 243, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black87,),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          controller: _photoSearchController,
          onChanged: (value){
            _searchListBloc.add(GetSearchPhotos(query: value));
          },
        ),
      ),
    );
  }
}