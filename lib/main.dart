import 'package:f05_lugares_app/data/DadosProvider.dart';
import 'package:f05_lugares_app/model/FavoritosProvider.dart';
import 'package:f05_lugares_app/screens/GerenciarLugares.dart';

import 'package:f05_lugares_app/screens/abas.dart';
import 'package:f05_lugares_app/screens/cadastroLugar.dart';
import 'package:f05_lugares_app/screens/configuracoes.dart';
import 'package:f05_lugares_app/screens/detalhes_lugar.dart';
import 'package:f05_lugares_app/screens/lugares_por_pais.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritosProvider()),
        ChangeNotifierProvider(create: (context) => LugarProvider()),
      ],
      child: MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => MinhasAbas(),
        '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
        '/detalheLugar': (ctx) => DetalhesLugarScreen(),
        '/configuracoes': (ctx) => ConfigracoesScreen(),
        '/cadastroLugar': (ctx) => CadastroLugarPage(),
        '/gerenciarLugares': (ctx) => GerenciarLugaresScreen(),
      },
    );
  }
}
