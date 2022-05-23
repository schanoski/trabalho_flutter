import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/aluno_helper.dart';

import '../../../models/aluno.dart';
import '../../components/components.dart';
import 'cadastro_aluno.dart';
import 'aluno_page.dart';

class ListaAlunoPage extends StatefulWidget {
  const ListaAlunoPage({Key? key}) : super(key: key);

  @override
  State<ListaAlunoPage> createState() => _ListaAlunoPageState();
}

class _ListaAlunoPageState extends State<ListaAlunoPage> {
  final _alunoHelper = AlunoHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alunos')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _abrirTelaCadastro,
      ),
      body: FutureBuilder(
        future: _alunoHelper.getTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Aluno>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Aluno> listaDados) {
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
                'Editar Aluno',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir Aluno',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(aluno: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _alunoHelper.apagar(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir essa Aluno?',
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

  Widget _criarItemLista(Aluno aluno) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                aluno.nome,
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      onLongPress: () => _abrirTelaCadastro(aluno: aluno),
    );
  }

  void _abrirTelaCadastro({Aluno? aluno}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroAluno(
                  aluno: aluno,
                )));

    setState(() {});
  }
}
