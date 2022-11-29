class TvShowResponse {
  List<Results>? results;

  TvShowResponse({this.results});

  TvShowResponse.fromJson(List<dynamic> json) {
    int index = 0;
    if (json.isNotEmpty) {
      results = <Results>[];
      for (var v in json) {
        results!.add(Results.fromJson(v));
        print(index);
        index++;
      }
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (results != null) {
      data = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? title;
  String? description;
  String? image;
  dynamic rating;

  Results({this.title, this.description, this.image, this.rating});

  Results.fromJson(Map<String, dynamic> json) {
    title = json['name'];
    description = json['summary'];
    image = json['image']['original'];
    rating = json['rating']['average']; // It works
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = title;
    data['summary'] = description;
    data['image']['original'] = image;
    data['rating']['average'] = rating;
    return data;
  }
}
