import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart'; // Importa la pantalla de login

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  // Expresión regular para validar la contraseña
  bool isValidPassword(String password) {
    String pattern = r'^(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  Future<http.Response> registerUserAPI(String username, String password) async {
    const String apiUrl = "https://latest-api-one.vercel.app/api/register";

    return http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
  }

  Future<void> registerUser() async {
    String username = usernameController.text.trim();
    String password = passwordController.text;

    if (!isValidPassword(password)) {
      _showErrorSnackBar("Password must be at least 8 characters, include a number and a special character.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await registerUserAPI(username, password);

      if (response.statusCode == 201) {
        _showSuccessSnackBar("Account created successfully!");

        // Espera 2 segundos para que el usuario vea el mensaje de éxito antes de redirigir
        await Future.delayed(const Duration(seconds: 2)); 

        // Redirigir a la pantalla de login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        _showErrorSnackBar(responseData["error"] ?? "Error while registering");
      }
    } catch (e) {
      _showErrorSnackBar("Connection error: ${e.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.greenAccent.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildBlurEffect(),
          _buildContent(),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Image.asset('assets/background.jpg', fit: BoxFit.cover),
    );
  }

  Widget _buildBlurEffect() {
    return Positioned.fill(
      child: Container(color: Colors.black.withOpacity(0.7)),
    );
  }

  Widget _buildContent() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildTitle(),
              const SizedBox(height: 30),
              _buildTextField(controller: usernameController, label: 'Username', icon: Icons.person_add_alt_1),
              const SizedBox(height: 20),
              _buildTextField(controller: passwordController, label: 'Password', icon: Icons.lock_outline, obscureText: true),
              const SizedBox(height: 30),
              isLoading ? _buildLoader() : _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Image.asset('assets/Shooter.jpg', height: 120, fit: BoxFit.contain),
        const SizedBox(height: 20),
        Text(
          'CREATE ACCOUNT',
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
            shadows: [Shadow(blurRadius: 20, color: Colors.cyanAccent, offset: Offset(0, 0))],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon, bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.cyanAccent,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.cyanAccent),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24), borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent), borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 50,
      left: 20,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: -5,
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.cyanAccent,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return GestureDetector(
      onTap: registerUser,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 200,
        height: 55,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.cyanAccent, Colors.blueAccent], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.cyanAccent.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: const Center(
          child: Text('REGISTER', style: TextStyle(fontFamily: 'Orbitron', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return const CircularProgressIndicator(color: Colors.cyanAccent, strokeWidth: 3);
  }
}
