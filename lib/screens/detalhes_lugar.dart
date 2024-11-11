import 'package:f05_lugares_app/model/FavoritosProvider.dart';
import 'package:f05_lugares_app/model/lugar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DetalhesLugarScreen extends StatelessWidget {
  const DetalhesLugarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lugar = ModalRoute.of(context)?.settings.arguments as Lugar;
    final favoritosProvider = Provider.of<FavoritosProvider>(context);

    void _favoritarLugar() {
      favoritosProvider.toggleFavorito(lugar);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          lugar.titulo,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              lugar.imagemUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Dicas',
              style: ThemeData().textTheme.displayLarge,
            ),
          ),
          Container(
            width: 350,
            height: 300,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemCount: lugar.recomendacoes.length,
              itemBuilder: (contexto, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(lugar.recomendacoes[index]),
                      subtitle: Text(lugar.titulo),
                      onTap: () {
                        print(lugar.recomendacoes[index]);
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _favoritarLugar,
        child: Icon(
          favoritosProvider.lugaresFavoritos.contains(lugar)
              ? Icons.star
              : Icons.star_border,
        ),
      ),
    );
  }
}
