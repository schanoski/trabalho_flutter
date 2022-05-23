import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/turma_helper.dart';

import '../../../models/turma.dart';
import '../../components/components.dart';
import 'turma_page.dart';

class ListaTurmaPage extends StatefulWidget {
  const ListaTurmaPage({Key? key}) : super(key: key);

  @override
  State<ListaTurmaPage> createState() => _ListaTurmaPageState();
}

class _ListaTurmaPageState extends State<ListaTurmaPage> {
  final _turmaHelper = TurmaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Turmas')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _abrirTelaCadastro,
      ),
      body: FutureBuilder(
        future: _turmaHelper.getTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Turma>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Turma> listaDados) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: listaDados.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            child: _criarItemLista(listaDados[index]),
            background: Container(
              alignment: const Alignment(-1, 0),
              color: Colors.blue,
              child: const Text(
                'Editar Turma',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir Turma',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(turma: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _turmaHelper.apagar(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir essa Turma?',
                    botoes: [
                      TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                      ElevatedButton(
                          child: const Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                    ]);
              }
              return true;
            },
          );
        });
  }

  Widget _criarItemLista(Turma turma) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                turma.nome,
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      //onTap: () => _inserirDadosTurma(turma),
      onLongPress: () => _abrirTelaCadastro(turma: turma),
    );
  }
/*
  void _inserirDadosTurma(Turma turma) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => InserirDadosTurmaPage(turma)
    ));
  }
*/

  void _abrirTelaCadastro({Turma? turma}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroTurma(
                  turma: turma,
                )));

    setState(() {});
  }
}
