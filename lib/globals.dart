library exam_project.globals;
import 'package:hive_flutter/hive_flutter.dart';

Future<bool> isFavorite(String id) async {
  return Hive.box('favorites').get(id) ?? false;
}

void setFavorite(String id, bool value) async {
  Hive.box('favorites').put(id, value);
}