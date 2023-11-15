import 'package:fitness/models/exercise_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiE {
  var XRapidAPIKey = '4fa689f444mshec61497929eff03p1e61f1jsn6c5e840ae89c';
  var XRapidAPIHost = 'exercisedb.p.rapidapi.com';

  Future<List<dynamic>> getBodyPartList() async {
    var res = await http.get(
        Uri.parse('https://exercisedb.p.rapidapi.com/exercises/bodyPartList'),
        headers: {
          'X-RapidAPI-Key': XRapidAPIKey,
          'X-RapidAPI-Host': XRapidAPIHost,
        });
    if (res.statusCode == 200) {
      var jsonres = jsonDecode(res.body);
      return jsonres;
    }
    return [];
  }

  Future<List<ExcerciceModel>?> getExcercices(String bodyPart) async {
    var res = await http.get(
        Uri.parse('https://exercisedb.p.rapidapi.com/exercises/bodyPart/$bodyPart'),
        headers: {
          'X-RapidAPI-Key': XRapidAPIKey,
          'X-RapidAPI-Host': XRapidAPIHost,
        });
    if (res.statusCode == 200) {
      var jsonres = jsonDecode(res.body) as List;
      return jsonres
          .map((excercice) => ExcerciceModel.fromMap(excercice))
          .toList();
    }
    return null;
  }
}
