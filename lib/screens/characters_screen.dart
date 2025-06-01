import 'package:flutter/material.dart';
import '../../models/character.dart';
import '../../services/api_service.dart';
import 'character_detail_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final ApiService apiService = ApiService();
  List<Character> characters = [];
  int page = 1;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchCharacters();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        page++;
        fetchCharacters();
      }
    });
  }

  Future<void> fetchCharacters() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedCharacters = await apiService.fetchCharacters(page);
      setState(() {
        characters.addAll(fetchedCharacters);
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personagens')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: characters.length + 1,
        itemBuilder: (context, index) {
          if (index < characters.length) {
            final character = characters[index];
            return ListTile(
              leading: Image.network(character.image),
              title: Text(character.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => CharacterDetailScreen(characterId: character.id),
                  ),
                );
              },
            );
          } else {
            return Center(
              child:
                  isLoading
                      ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      )
                      : const SizedBox.shrink(),
            );
          }
        },
      ),
    );
  }
}
