import 'package:exam_project/api/tv_show_remote.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TvShowEntity {
  String id;
  String title;
  String description;
  String image;
  List<dynamic> genres;
  num? rating;
  String status;
  bool favorite;

  TvShowEntity(this.id, this.title, this.description, this.image, this.genres,
      this.rating, this.status, this.favorite){
    if(Hive.box('favorites').get(id) == null){
      Hive.box('favorites').put(id, false);
    }
    favorite = Hive.box('favorites').get(id);
  }
}

extension TvShowMapper on TvShowRemote {
  TvShowEntity toEntity() {
    return TvShowEntity(
        id, title, description, image, genres, rating, status, false);
  }
}
