import 'dart:async';
import 'package:exam_project/api/tv_show_response.dart';
import 'package:exam_project/entities/tv_show_entity.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class TvShowBloc {

  List<TvShowEntity> showsList = List.empty();

  getTvShows() async {
    if(showsList.isEmpty) {
      showsList = await _fetchTvShowsList();
      print(showsList.length);
    }
  }

  Future<List<TvShowEntity>> _fetchTvShowsList() async {
    var url = Uri.parse("https://api.tvmaze.com/shows");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        var responseList = convert.jsonDecode(response.body) as List<dynamic>;
        var tvShowResponse = TvShowResponse.fromJson(responseList);
        return tvShowResponse.toEntity();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load shows');
      }
    }
    catch(e) {
      print(e);
    }

    return List.empty();
  }
}