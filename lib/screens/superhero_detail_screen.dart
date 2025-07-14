import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superHero;
  const SuperheroDetailScreen({super.key, required this.superHero});

  @override
  Widget build(BuildContext context) {
    double safeParse(String biography) {
      final parsed = double.tryParse(biography);

      return parsed ?? 0.0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Superhero: ${superHero.name}"),
      ),
      body: Column(
        children: [
          Image.network(
            superHero.url,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[800],
                child: const Column(
                  children: [
                    Text("Imagen no disponible",
                        style: TextStyle(color: Colors.white70)),
                    Icon(
                      Icons.broken_image,
                      color: Colors.white70,
                      size: 100,
                    ),
                  ],
                ),
              );
            },
          ),
          Text(
            superHero.name,
            style: const TextStyle(fontSize: 28),
          ),
          Text(
            superHero.realName,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          Text(
            "Combate: ${superHero.powerStatsResponse.combat}",
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 130,
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Barra Power
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: safeParse(superHero.powerStatsResponse.power),
                          width: 20,
                          color: Colors.red),
                      const Text("Power")
                    ],
                  ),
                  // Barra Speed
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: safeParse(
                              superHero.powerStatsResponse.intelligence),
                          width: 20,
                          color: Colors.blue),
                      const Text("intelligence")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height:
                              safeParse(superHero.powerStatsResponse.strength),
                          width: 20,
                          color: Colors.grey),
                      const Text("strengt ")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: safeParse(superHero.powerStatsResponse.speed),
                          width: 20,
                          color: Colors.red),
                      const Text("speed")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: safeParse(
                              superHero.powerStatsResponse.durability),
                          width: 20,
                          color: Colors.deepOrange),
                      const Text("durability")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height:
                              safeParse(superHero.powerStatsResponse.combat),
                          width: 20,
                          color: Colors.black),
                      const Text("combat")
                    ],
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
