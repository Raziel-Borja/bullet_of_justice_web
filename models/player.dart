class Player {
  final String username;
  final int score;
  final DateTime createdAt;

  Player({
    required this.username,
    required this.score,
    required this.createdAt,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      username: json['username'],
      score: json['score'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
