import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/player.dart';
import '../models/user.dart';

class ApiService {
  final String baseUrl =
      'https://your-nextjs-api-url.com/api'; // Reemplaza con la URL de tu API

  // Obtener la lista de jugadores (scoreboard)
  Future<List<Player>> getPlayers() async {
    final response = await http.get(Uri.parse('$baseUrl/scoreboard'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((player) => Player.fromJson(player)).toList();
    } else {
      throw Exception('Failed to load players');
    }
  }

  // Registrar un nuevo usuario
  Future<void> registerUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register user');
    }
  }

  // Iniciar sesión
  Future<User> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
