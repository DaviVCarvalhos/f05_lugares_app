import 'package:f05_lugares_app/data/DadosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:f05_lugares_app/model/lugar.dart';


class CadastroLugarPage extends StatefulWidget {
  @override
  _CadastroLugarPageState createState() => _CadastroLugarPageState();
}

class _CadastroLugarPageState extends State<CadastroLugarPage> {
  final _tituloController = TextEditingController();
  final _imagemUrlController = TextEditingController();
  final _custoController = TextEditingController();
  final _avaliacaoController = TextEditingController();
  final _recomendacoesController = TextEditingController();

  final _paisesSelecionados = <String>[];

  void _adicionarLugar() {
    if (_tituloController.text.isEmpty ||
        _imagemUrlController.text.isEmpty ||
        _custoController.text.isEmpty ||
        _avaliacaoController.text.isEmpty ||
        _recomendacoesController.text.isEmpty ||
        _paisesSelecionados.isEmpty) {
      return;
    }

    final novoLugar = Lugar(
      id: DateTime.now().toString(),
      titulo: _tituloController.text,
      paises: _paisesSelecionados,
      imagemUrl: _imagemUrlController.text,
      avaliacao: double.parse(_avaliacaoController.text),
      custoMedio: double.parse(_custoController.text),
      recomendacoes: _recomendacoesController.text
          .split('\n')
          .map((recomendacao) => recomendacao.trim())
          .toList(),
    );

    // Usando o provider para adicionar o novo lugar
    Provider.of<LugarProvider>(context, listen: false).adicionarLugar(novoLugar);

    // Exibir uma mensagem de sucesso (Snackbar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Novo lugar adicionado!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Limpar campos após o cadastro
    _tituloController.clear();
    _imagemUrlController.clear();
    _custoController.clear();
    _avaliacaoController.clear();
    _recomendacoesController.clear();
    setState(() {
      _paisesSelecionados.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final paises = Provider.of<LugarProvider>(context).paises;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Lugar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título do Lugar'),
              ),
              TextField(
                controller: _imagemUrlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
              TextField(
                controller: _custoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Custo Médio'),
              ),
              TextField(
                controller: _avaliacaoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Avaliação'),
              ),
              TextField(
                controller: _recomendacoesController,
                decoration: InputDecoration(labelText: 'Recomendações (separadas por nova linha)'),
                maxLines: 5,
              ),
              SizedBox(height: 10),
              Text('Selecione os Países', style: TextStyle(fontSize: 16)),
              Wrap(
                children: paises
                    .map((pais) => ChoiceChip(
                          label: Text(pais.titulo),
                          selected: _paisesSelecionados.contains(pais.id),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _paisesSelecionados.add(pais.id);
                              } else {
                                _paisesSelecionados.remove(pais.id);
                              }
                            });
                          },
                        ))
                    .toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _adicionarLugar,
                child: Text('Cadastrar Lugar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
