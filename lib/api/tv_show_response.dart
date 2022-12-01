class TvShowRemote {
  String id = '';
  String title = '';
  String description = '';
  String image = '';
  num? rating;

  TvShowRemote(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.rating});

  TvShowRemote.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['name'];
    description = json['summary'];
    image = json['image']['original'];
    rating = json['rating']['average'];
  }
}


