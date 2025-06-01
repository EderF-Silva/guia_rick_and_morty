import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guia Rick and Morty')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Explore personagens e locais do universo de Rick and Morty!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/characters');
              },
              child: const Text('Personagens'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/locations');
              },
              child: const Text('Locais'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/favorites');
              },
              child: const Text('Favoritos'),
            ),
          ],
        ),
      ),
    );
  }
}
