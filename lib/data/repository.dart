import 'dart:convert';

import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<SuperheroResponse?> fetchSuperHero(String name) async {
    final response = await http.get(Uri.parse(
        "https://superheroapi.com/api/f21bbed3e10a6c9851b4ea07106e5fff/search/$name"));

    if (response.statusCode == 200) {
      final decodeJson = jsonDecode(response.body);

      return SuperheroResponse.fromJson(decodeJson);
    } else {
      return null;
    }
  }
}
