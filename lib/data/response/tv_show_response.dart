class TvShowResponse {
  int? responseCode;
  List<Results>? results;

  TvShowResponse({this.responseCode, this.results});

  TvShowResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? title;
  String? description;
  String? image;
  double? rating;

  Results(
      {this.title,
        this.description,
        this.image,
        this.rating
      });

  Results.fromJson(Map<String, dynamic> json) {
    title = json['name'];
    description = json['summary'];
    image = json['image']['original'];
    rating = json['rating']['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.title;
    data['summary'] = this.description;
    data['image']['original'] = this.image;
    data['rating']['average'] = this.rating;
    return data;
  }
}