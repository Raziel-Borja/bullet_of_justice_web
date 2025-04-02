import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ScoreboardPage extends StatefulWidget {
  @override
  _ScoreboardPageState createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  List<Map<String, dynamic>> players = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchScores();
  }

  Future<void> fetchScores() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final response = await http.get(Uri.parse('https://latest-api-one.vercel.app/api/scores'));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true) {
          List<dynamic> data = responseBody['data'];

          List<Map<String, dynamic>> tempPlayers = List<Map<String, dynamic>>.from(data.map((player) => {
            'username': player['username'] ?? 'Sin nombre',
            'kills': player['kills'] ?? 0,
          }));

          tempPlayers.sort((a, b) => b['kills'].compareTo(a['kills']));

          for (int i = 0; i < tempPlayers.length; i++) {
            tempPlayers[i]['position'] = i + 1;
          }

          setState(() {
            players = tempPlayers;
            isLoading = false;
          });
        } else {
          throw Exception("Error while obtaining the scores");
        }
      } else {
        throw Exception("Error while obtaining the scores");
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print("🔥 Error while obtaining the scores: $e");
    }
  }

  void logout() {
    print("Sesión cerrada");
    Navigator.pop(context); // O cambia esto para redirigir al login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Scoreboard',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.power_settings_new, color: Colors.white),
          onPressed: logout,
          tooltip: "Logout",
        ),
        actions: [
          IconButton(
            onPressed: fetchScores,
            icon: Icon(Icons.refresh, color: Colors.white),
            tooltip: "Update Scores",
          ),
        ],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : hasError
                      ? Center(
                          child: Text(
                            "Error while loading the scores",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: players.length,
                            itemBuilder: (context, index) => buildPlayerCard(players[index], index),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlayerCard(Map<String, dynamic> player, int index) {
    bool isTop3 = index < 3;
    Color cardColor;
    IconData icon;

    switch (index) {
      case 0:
        cardColor = Colors.amberAccent.shade700;
        icon = Icons.emoji_events;
        break;
      case 1:
        cardColor = Colors.grey;
        icon = Icons.emoji_events;
        break;
      case 2:
        cardColor = Colors.brown;
        icon = Icons.emoji_events;
        break;
      default:
        cardColor = Colors.grey[850]!;
        icon = Icons.person;
    }

    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Card(
            elevation: isTop3 ? 20 : 5,
            shadowColor: isTop3 ? cardColor : Colors.black,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: cardColor.withOpacity(isTop3 ? 0.9 : 1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isTop3 ? cardColor : Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isTop3
                          ? Icon(
                              icon,
                              color: Colors.white,
                            )
                          : Text(
                              player['position'].toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      player['username'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.sentiment_very_dissatisfied_rounded, color: Colors.redAccent),
                        SizedBox(width: 4),
                        Text(
                          '${player['kills']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
