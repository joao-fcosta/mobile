import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../models/brawler.dart';

class BrawlStarsApi {
  static Future<List<Brawler>> buscarBrawlers(String tag, int meta) async {
    final url = Uri.parse("$apiBaseUrl/players/%23$tag");
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $apiToken"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List brawlers = data["brawlers"];
      return brawlers.map((b) => Brawler.fromJson(b, meta)).toList();
    } else {
      throw Exception("Erro: ${response.body}");
    }
  }
}
