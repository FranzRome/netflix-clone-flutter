class TvShowRemote {
  String id = '';
  String title = '';
  String description = '';
  String image = '';
  List<dynamic> genres = <dynamic>[];
  num? rating;
  String status = '';

  TvShowRemote(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.genres,
      required this.rating,
      required this.status});

  TvShowRemote.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['name'];
    description = json['summary'];
    genres = json['genres'];
    image = json['image']['original'];
    rating = json['rating']['average'];
    status = json['status'];
  }
}
