import 'package:flutter/material.dart';
import 'package:got_flutter/character_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<List<Character>> fetchBbCharacters() async {
    final response =
        await http.get(Uri.parse('https://thronesapi.com/api/v2/Characters'));

    if (response.statusCode == 200) {
      final List<dynamic> charactersJson = jsonDecode(response.body);
      return charactersJson.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game of Thrones Characters'),
      ),
      body: FutureBuilder<List<Character>>(
        future: fetchBbCharacters(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final characters = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return CharacterTile(character: characters[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
