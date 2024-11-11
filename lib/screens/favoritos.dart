import 'package:f05_lugares_app/components/item_lugar.dart';
import 'package:f05_lugares_app/model/FavoritosProvider.dart';
import 'package:f05_lugares_app/model/lugar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key, required List<Lugar> lugaresFavoritos});

  @override
  Widget build(BuildContext context) {
    final favoritosProvider = Provider.of<FavoritosProvider>(context);
    final lugaresFavoritos = favoritosProvider.lugaresFavoritos;

    if (lugaresFavoritos.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum Lugar Marcado como Favorito!',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: lugaresFavoritos.length,
        itemBuilder: (ctx, index) {
          return ItemLugar(lugar: lugaresFavoritos[index]);
        },
      );
    }
  }
}