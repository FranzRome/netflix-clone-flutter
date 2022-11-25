import 'package:exam_project/data/response/tv_show_response.dart';

class TvShowEntity {
  String? title;
  String? description;
  String? image;
  double? rating;

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
          double rating = e.rating ?? 0;

          return TvShowEntity(title, description, image, rating);
        }).toList() ?? List.empty();
  }
}
