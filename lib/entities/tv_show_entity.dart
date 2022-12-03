import 'package:exam_project/api/tv_show_remote.dart';

class TvShowEntity {
  String id;
  String title;
  String description;
  String image;
  List<dynamic> genres;
  num? rating;
  String status;

  TvShowEntity(this.id, this.title, this.description, this.image, this.genres,
      this.rating, this.status);
}

extension TvShowMapper on TvShowRemote {
  TvShowEntity toEntity() {
    return TvShowEntity(id, title, description, image, genres, rating, status);
  }
}
