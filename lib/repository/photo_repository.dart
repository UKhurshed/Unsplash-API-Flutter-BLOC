import 'package:dio/dio.dart';
import 'package:pic_load/model/item_picture.dart';

abstract class PhotoRepository{
  Future<List<PhotoListBean>> getPhotos(int page);
}


class PhotoRepositoryImpl implements PhotoRepository{

  final BASE_URL = 'https://api.unsplash.com/photos/?';
  final ACCESS_KEY = 'THjOqap-3xIs3HNTyCBy4yEDKBIhqxs_sGvtuZNc2FQ';
  final clientId = 'client_id=';

  @override
  Future<List<PhotoListBean>> getPhotos(int page) async{
    List<PhotoListBean> list = [];
      try{
        Response response = await Dio().get(BASE_URL + clientId + ACCESS_KEY + '&page=$page');

        if(response.statusCode == 200){
          list =  PhotoListResponse.fromJsonArray(response.data).results;
          print(list.length);
        }
        return list;
      }catch(error){
        print('Error $error');
      }
  }

}

