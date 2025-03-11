import 'package:flutter/material.dart';
import 'dart:ui';
import 'login_page.dart';
import 'register_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildBlurEffect(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: Image.asset(
        'assets/background.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBlurEffect() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(color: Colors.black.withOpacity(0.4)),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 20),
          _buildDescription(),
          const SizedBox(height: 40),
          _buildGradientButton(
            text: 'LOGIN',
            gradientColors: [Colors.redAccent, Colors.deepOrange],
            onPressed: () => _navigateToPage(context, LoginPage()),
          ),
          const SizedBox(height: 20),
          _buildGradientButton(
            text: 'REGISTER',
            gradientColors: [Colors.blueAccent, Colors.lightBlue],
            onPressed: () => _navigateToPage(context, RegisterPage()),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Bullet 4 Justice',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Orbitron',
        fontSize: 55,
        fontWeight: FontWeight.bold,
        color: Colors.redAccent,
        letterSpacing: 2,
        shadows: [
          Shadow(
            blurRadius: 15,
            color: Colors.black,
            offset: Offset(4, 4),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: const Text(
          'The battle for justice begins now.\nWill you stand with Daniel Carter '
          'and fight for those who cannot fight for themselves?\n\n'
          'Bullet 4 Justice is more than just a game—it’s a call to action.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required List<Color> gradientColors,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 55,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
