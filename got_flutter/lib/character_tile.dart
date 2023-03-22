import 'models.dart';
import 'package:flutter/material.dart';
import 'package:got_flutter/quotes_screen.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({Key? key, required this.character}) : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FamilyScreen(id: character.id),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(character.imageUrl),
            ),
            Text(character.firstName),
          ],
        ),
      ),
    );
  }
}
