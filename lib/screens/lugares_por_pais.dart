import 'package:f05_lugares_app/components/item_lugar.dart';
import 'package:f05_lugares_app/data/DadosProvider.dart';
import 'package:f05_lugares_app/model/lugar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importando o provider

import 'package:f05_lugares_app/model/pais.dart'; // Importando Pais

class LugarPorPaisScreen extends StatelessWidget {
  
  LugarPorPaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Acessando o país da navegação (passado como argumento)
    final pais = ModalRoute.of(context)?.settings.arguments as Pais;
    
    // Acessando a lista de lugares do LugarProvider
    final lugares = Provider.of<LugarProvider>(context).lugares;
    
    // Filtrando os lugares que pertencem ao país selecionado
    final List<Lugar> lugaresPorPais = lugares.where((lugar) {
      return lugar.paises.contains(pais.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
         backgroundColor: pais.cor,
        title: Text(
          "Lugares em ${pais.titulo}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: lugaresPorPais.length,
        itemBuilder: (context, index) {
          return ItemLugar(lugar: lugaresPorPais.elementAt(index));
        },
      ),
    );
  }
}
