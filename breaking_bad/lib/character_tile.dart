import 'models.dart';
import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({Key? key, required this.character}) : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(character.imageUrl),
          ),
          Text(character.firstName),
        ],
      ),
    );
  }
}
