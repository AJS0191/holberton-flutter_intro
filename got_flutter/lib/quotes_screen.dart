import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

class FamilyScreen extends StatelessWidget {
  final int id;

  const FamilyScreen({super.key, required this.id});

  Future<String> fetchInfo(id) async {
    final response = await http
        .get(Uri.parse('https://thronesapi.com/api/v2/Characters/$id'));

    if (response.statusCode == 200) {
      final char = jsonDecode(response.body);
      Character charO = Character.fromJson(char);
      return charO.family;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: fetchInfo(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final family = snapshot.data!;
            return Center(child: Text(family));
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
