import 'package:exam_project/api/tv_show_response.dart';

class TvShowEntity {
  String id;
  String title;
  String description;
  String image;
  num? rating;

  TvShowEntity(this.id, this.title, this.description, this.image, this.rating);
}

extension TvShowMapper on TvShowRemote {
  TvShowEntity toEntity() {
    return TvShowEntity(id, title, description, image, rating);
  }
}
