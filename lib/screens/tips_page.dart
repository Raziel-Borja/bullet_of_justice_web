import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  final List<String> tips = [
    "Always keep moving to avoid being an easy target.",
    "Use cover to your advantage, never stay in the open.",
    "Reload only when you're in a safe spot.",
    "Communicate with your team for better strategy.",
    "Listen carefully for enemy footsteps and gunshots.",
    "Stay aware of the map's hot zones and choke points.",
    "Control your fire rate to improve accuracy.",
    "Throw grenades before rushing a room.",
    "Use high ground for a tactical advantage.",
    "Always heal yourself before engaging in another fight."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Bullet 4 Justice Tips',
          style:
              TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.redAccent.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: tips.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.black.withOpacity(0.7),
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.redAccent),
                  title: Text(
                    tips[index],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
