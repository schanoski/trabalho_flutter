import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/professor_helper.dart';

import '../../../models/professor.dart';
import '../../components/components.dart';
import 'professor_page.dart';

class ListaProfessorPage extends StatefulWidget {
  const ListaProfessorPage({Key? key}) : super(key: key);

  @override
  State<ListaProfessorPage> createState() => _ListaProfessorPageState();
}

class _ListaProfessorPageState extends State<ListaProfessorPage> {
  final _professorHelper = ProfessorHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Professores')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _abrirTelaCadastro,
      ),
      body: FutureBuilder(
        future: _professorHelper.getTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Professor>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Professor> listaDados) {
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
                'Editar Professor',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir Professor',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(professor: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _professorHelper.apagar(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir essa Professor?',
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

  Widget _criarItemLista(Professor professor) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                professor.nome,
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      onLongPress: () => _abrirTelaCadastro(professor: professor),
    );
  }

  void _abrirTelaCadastro({Professor? professor}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroProfessor(
                  professor: professor,
                )));

    setState(() {});
  }
}
