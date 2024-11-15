import 'package:f05_lugares_app/data/DadosProvider.dart';
import 'package:f05_lugares_app/model/lugar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class CadastroLugarPage extends StatelessWidget {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _imagemUrlController = TextEditingController();
  final TextEditingController _avaliacaoController = TextEditingController();
  final TextEditingController _custoMedioController = TextEditingController();
  final TextEditingController _recomendacoesController =
      TextEditingController();

  String? _paisSelecionado; // Armazena o ID do país selecionado

  @override
  Widget build(BuildContext context) {
    final paises = Provider.of<LugarProvider>(context).paises;

    void _cadastrarLugar() {
      final String titulo = _tituloController.text;
      final String imagemUrl = _imagemUrlController.text;
      final double avaliacao = double.tryParse(_avaliacaoController.text) ?? -1;
      final double custoMedio =
          double.tryParse(_custoMedioController.text) ?? 0;
      final List<String> recomendacoes =
          _recomendacoesController.text.split(',');

      if (titulo.isEmpty || imagemUrl.isEmpty || _paisSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Preencha todos os campos obrigatórios.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      if (avaliacao < 0 || avaliacao > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('A avaliação deve estar entre 0 e 5.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      final novoLugar = Lugar(
        id: Random().nextDouble().toString(),
        titulo: titulo,
        imagemUrl: imagemUrl,
        avaliacao: avaliacao,
        custoMedio: custoMedio,
        recomendacoes: recomendacoes,
        paises: [_paisSelecionado!], // Vincula o lugar ao país selecionado
      );

      Provider.of<LugarProvider>(context, listen: false)
          .adicionarLugar(novoLugar);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lugar "$titulo" cadastrado com sucesso!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Lugar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _imagemUrlController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
            ),
            TextField(
              controller: _avaliacaoController,
              decoration: InputDecoration(labelText: 'Avaliação'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _custoMedioController,
              decoration: InputDecoration(labelText: 'Custo Médio'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _recomendacoesController,
              decoration: InputDecoration(
                  labelText: 'Recomendações (separadas por vírgula)'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _paisSelecionado,
              decoration: InputDecoration(labelText: 'Selecione o País'),
              items: paises.map((pais) {
                return DropdownMenuItem<String>(
                  value: pais.id,
                  child: Text(pais.titulo),
                );
              }).toList(),
              onChanged: (value) {
                _paisSelecionado = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Por favor, selecione um país.';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cadastrarLugar,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
