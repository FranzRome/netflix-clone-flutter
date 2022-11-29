import 'package:exam_project/api/tv_show_response.dart';

class TvShowEntity {
  String? title;
  String? description;
  String? image;
  dynamic rating;

  TvShowEntity(
       this.title,
       this.description,
       this.image,
       this.rating);
}

extension TvShowMapper on TvShowResponse {
  List<TvShowEntity> toEntity() {
    return results?.map((e) {
          String title = e.title ?? "";
          String description = e.description ?? "";
          String image = e.image ?? "";
          dynamic rating = e.rating ?? 0;

          return TvShowEntity(title, description, image, rating);
        }).toList() ?? List.empty();
  }
}
