import 'dart:async';
import 'dart:convert' as convert;
import 'package:exam_project/data/response/tv_show_response.dart';
import 'package:http/http.dart' as http;
import 'package:exam_project/domain/entity/tv_show_entity.dart';

class TvShowBloc {
  Future<List<TvShowEntity>> _fetchTvShowsList() async {

    var url = Uri.parse("https://api.tvmaze.com/shows");
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var responseMap = convert.jsonDecode(response.body) as Map<String, dynamic>;
        var tvShowResponse = TvShowResponse.fromJson(responseMap);
        return tvShowResponse.toEntity();
      }
    }
    catch(e) {
      print(e);
    }

    return List.empty();
  }
}