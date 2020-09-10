import 'package:dio/dio.dart';
import 'package:pic_load/model/search_photos.dart';

abstract class SearchPhotoRepository{
  Future<List<SearchPhotoList>> getPhotos(String query);
}

class SearchPhotoRepositoryImpl implements SearchPhotoRepository{

  final BASE_URL = 'https://api.unsplash.com/search/photos?';
  final ACCESS_KEY = 'THjOqap-3xIs3HNTyCBy4yEDKBIhqxs_sGvtuZNc2FQ';
  final clientId = 'client_id=';
  final page = 'page=1';
  @override
  Future<List<SearchPhotoList>> getPhotos(String query) async{
    List<SearchPhotoList> list = [];
    try{
      Response response = await Dio().get('$BASE_URL$page&query=$query&$clientId$ACCESS_KEY');

      if(response.statusCode == 200){
        list =  SearchPhotoListResponse.fromJsonArray(response.data).results;
        print('Length ${list.length}');
      }
      return list;
    }catch(error){
      print('Error $error');
    }
  }

}