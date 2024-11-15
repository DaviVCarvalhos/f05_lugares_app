import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/DadosProvider.dart';
import '../model/lugar.dart';

class GerenciarLugaresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lugares = Provider.of<LugarProvider>(context).lugares;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Lugares'),
      ),
      body: ListView.builder(
        itemCount: lugares.length,
        itemBuilder: (ctx, i) {
          final lugar = lugares[i];
          return ListTile(
            title: Text(lugar.titulo),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(lugar.imagemUrl),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _abrirModalEdicao(context, lugar),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () => _confirmarRemocao(context, lugar),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _confirmarRemocao(BuildContext context, Lugar lugar) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Remover Lugar'),
        content: Text('Tem certeza que deseja remover "${lugar.titulo}"?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Confirmar'),
            onPressed: () {
              Provider.of<LugarProvider>(context, listen: false)
                  .removerLugar(lugar);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Lugar "${lugar.titulo}" removido.'),
                  backgroundColor: Colors.red,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _abrirModalEdicao(BuildContext context, Lugar lugar) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        final tituloController = TextEditingController(text: lugar.titulo);
        final imagemUrlController =
            TextEditingController(text: lugar.imagemUrl);

        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: imagemUrlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Provider.of<LugarProvider>(context, listen: false)
                      .alterarLugar(
                    lugar.id,
                    tituloController.text,
                    imagemUrlController.text,
                  );
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lugar "${lugar.titulo}" alterado.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Text('Salvar Alterações'),
              ),
            ],
          ),
        );
      },
    );
  }
}
