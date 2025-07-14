import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/repository.dart';
import 'package:superhero_app/screens/superhero_detail_screen.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  Repository repository = Repository();
  Future<SuperheroResponse?>? _superHeroInfo;
  bool _isTextEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Super Hero Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Busca un heroe",
                  /* hintText: "Busca un heroe", */
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (text) {
                setState(() {
                  _isTextEmpty = text.isEmpty;
                  _superHeroInfo = repository.fetchSuperHero(text);
                });
              },
            ),
          ),
          bodyList(_isTextEmpty)
        ],
      ),
    );
  }

  FutureBuilder<SuperheroResponse?> bodyList(bool isTextEmpty) {
    return FutureBuilder(
      future: _superHeroInfo,
      builder: (context, snapshot) {
        if (_isTextEmpty) return const Text("Introduce un nombre");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          var superHeroList = snapshot.data?.result;
          return Expanded(
            child: ListView.builder(
              itemCount: superHeroList?.length ?? 0,
              itemBuilder: (context, index) {
                if (superHeroList != null) {
                  return itemSuperhero(superHeroList[index]);
                } else {
                  return const Text("Error");
                }
              },
            ),
          );
        } else if (snapshot.hasError) {
          return const Text("Ocurrio un error.");
        } else {
          return const Text("No hay datos");
        }
      },
    );
  }

  Padding itemSuperhero(SuperheroDetailResponse item) => Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.red),
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuperheroDetailScreen(superHero: item),
                )),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    item.url,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -0.6),
                  ),
                ),
                Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      );
}
