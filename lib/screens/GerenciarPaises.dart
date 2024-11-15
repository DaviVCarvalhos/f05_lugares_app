import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/DadosProvider.dart';
import '../model/pais.dart';

class GerenciarPaisesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paises = Provider.of<LugarProvider>(context).paises;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Países'),
      ),
      body: ListView.builder(
        itemCount: paises.length,
        itemBuilder: (ctx, i) {
          final pais = paises[i];
          return ListTile(
            title: Text(pais.titulo),
            leading: CircleAvatar(
              backgroundColor: pais.cor,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _abrirModalEdicao(context, pais),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () => _confirmarRemocao(context, pais),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirModalCadastro(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _abrirModalCadastro(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        final tituloController = TextEditingController();

        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: InputDecoration(labelText: 'Nome do País'),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<LugarProvider>(context, listen: false)
                      .adicionarPais(
                    Pais(
                      id: DateTime.now().toString(),
                      titulo: tituloController.text,
                    ),
                  );
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('País "${tituloController.text}" cadastrado.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _abrirModalEdicao(BuildContext context, Pais pais) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        final tituloController = TextEditingController(text: pais.titulo);

        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: InputDecoration(labelText: 'Nome do País'),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<LugarProvider>(context, listen: false)
                      .alterarPais(
                    pais.id,
                    tituloController.text,
                  );
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('País "${tituloController.text}" alterado.'),
                      backgroundColor: Colors.blue,
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

  void _confirmarRemocao(BuildContext context, Pais pais) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Remover País'),
        content: Text('Tem certeza que deseja remover "${pais.titulo}"?'),
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
                  .removerPais(pais);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('País "${pais.titulo}" removido.'),
                  backgroundColor: Colors.red,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
