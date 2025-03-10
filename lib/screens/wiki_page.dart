import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WikiPage extends StatelessWidget {
  final List<Map<String, dynamic>> characters = [
    {
      'name': 'Daniel Carter',
      'description':
          'A brilliant and strategic leader with exceptional tactical skills. Daniel is known for his ability to read the battlefield and make quick, decisive actions. His leadership has saved countless missions from failure.',
      'image': 'assets/Daniel_Carter.png',
    },
    {
      'name': 'Light Taliban',
      'description':
          'A stealth specialist trained in long-range eliminations. Light Taliban uses his camouflaging abilities to remain hidden and take down high-value targets from a distance. His precision and stealth make him a deadly adversary.',
      'image': 'assets/taliban_ligero.png',
    },
    {
      'name': 'Tactical Taliban',
      'description':
          'A heavily armored soldier built for endurance and firepower. Tactical Taliban thrives in the heat of battle, capable of withstanding massive damage while protecting his allies. His heavy weaponry and defensive skills make him an unstoppable force.',
      'image': 'assets/taliban_sigiloso.png',
    },
    {
      'name': 'Male Civilian',
      'description':
          'A skilled medic and field operator, dedicated to providing first aid and support to his team. His quick thinking and medical knowledge have saved many lives in critical situations.',
      'image': 'assets/male_civilian.png',
    },
    {
      'name': 'Female Civilian',
      'description':
          'A non-combatant civilian who plays a crucial role in providing logistical and communication support. Despite not being on the frontlines, her assistance is invaluable to the team’s success.',
      'image': 'assets/female_civilian.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Characters Wiki',
          style: GoogleFonts.bebasNeue(
            fontSize: 28,
            color: Colors.redAccent,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;

            if (constraints.maxWidth < 600) {
              crossAxisCount = 1;
            } else if (constraints.maxWidth < 900) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 3;
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(
                          name: character['name'],
                          description: character['description'],
                          image: character['image'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character['name'],
                            style: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            character['description'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Click to see the character photo',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CharacterDetailPage extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  const CharacterDetailPage({
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(name, style: GoogleFonts.bebasNeue(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
