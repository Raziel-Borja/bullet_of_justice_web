import 'package:flutter/material.dart';

class WikiPage extends StatelessWidget {
  // Lista de ejemplo de personajes con sus detalles
  final List<Map<String, dynamic>> characters = [
    {
      'name': 'Daniel Carter',
      'description':
          'Un líder estratégico con habilidades tácticas excepcionales.',
      'image': 'assets/Daniel_Carter.png',
    },
    {
      'name': 'Light Taliban',
      'description':
          'Especialista en eliminaciones a larga distancia y sigilo.',
      'image': 'assets/taliban_ligero.png',
    },
    {
      'name': 'Tactical Taliban',
      'description': 'Tanquero con gran resistencia y poder de fuego.',
      'image': 'assets/taliban_sigiloso.png',
    },
    {
      'name': 'Male Civilian',
      'description': 'Sanadora experta en apoyo y recuperación de aliados.',
      'image': 'assets/male_civilian.png',
    },
    {
      'name': 'Female Civilian',
      'description': 'Civil femenina.',
      'image': 'assets/female_civilian.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Characters Wiki',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.black,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing: 16, // Espacio entre columnas
                  mainAxisSpacing: 16, // Espacio entre filas
                  childAspectRatio: 1, // Relación de aspecto cuadrada (1:1)
                ),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.grey[850],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Foto del personaje
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.asset(
                              character['image'],
                              width: double.infinity,
                              fit: BoxFit
                                  .cover, // Ajusta la imagen al tamaño del contenedor
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nombre del personaje
                              Text(
                                character['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              // Descripción del personaje
                              Text(
                                character['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
