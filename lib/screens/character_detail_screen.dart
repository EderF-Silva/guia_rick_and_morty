import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/character.dart';
import '../../providers/favorites_provider.dart';
import '../../services/api_service.dart';

class CharacterDetailScreen extends StatefulWidget {
  final int characterId;

  const CharacterDetailScreen({super.key, required this.characterId});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  final ApiService apiService = ApiService();
  Character? character;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCharacter();
  }

  Future<void> fetchCharacter() async {
    try {
      final fetchedCharacter = await apiService.fetchCharacterById(
        widget.characterId,
      );
      setState(() {
        character = fetchedCharacter;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Personagem'),
        actions: [
          IconButton(
            icon: Icon(
              favoritesProvider.isFavorite(widget.characterId)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              favoritesProvider.toggleFavorite(widget.characterId);
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : character == null
              ? const Center(child: Text('Erro ao carregar dados'))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(character!.image),
                    const SizedBox(height: 10),
                    Text(
                      character!.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    infoTile('Status', character!.status),
                    infoTile('Espécie', character!.species),
                    infoTile('Gênero', character!.gender),
                    infoTile('Origem', character!.origin),
                    infoTile('Localização', character!.location),
                  ],
                ),
              ),
    );
  }

  Widget infoTile(String title, String value) {
    return ListTile(title: Text(title), subtitle: Text(value));
  }
}
