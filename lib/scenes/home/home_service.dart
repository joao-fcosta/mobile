import 'dart:convert';
import 'package:http/http.dart' as http;

class ConsumoService {
  static final String _baseUrl = "http://127.0.0.1:8000/predict";

  static Future<Map<String, dynamic>?> consultarConsumo(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      // Esse print pode ser substituído por snackbar / log personalizado
      print("Erro ao consultar consumo: $e");
    }

    return null;
  }
}
