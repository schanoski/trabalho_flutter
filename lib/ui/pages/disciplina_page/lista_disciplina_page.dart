import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/disciplina_helper.dart';
import 'package:trabalho_final_flutter/ui/pages/lancar_notas_frequencias_page/cadastrar_notas_frequencias.dart';

import '../../../models/disciplina.dart';
import '../../components/components.dart';
import '../lancar_notas_frequencias_page/lista_nota_frequencia.dart';
import 'cadastro_disciplina.dart';
import 'disciplina_page.dart';

class ListaDisciplinaPage extends StatefulWidget {
  const ListaDisciplinaPage({Key? key}) : super(key: key);

  @override
  State<ListaDisciplinaPage> createState() => _ListaDisciplinaPageState();
}

class _ListaDisciplinaPageState extends State<ListaDisciplinaPage> {
  final _disciplinaHelper = DisciplinaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disciplinas')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _abrirTelaCadastro,
      ),
      body: FutureBuilder(
        future: _disciplinaHelper.getTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Disciplina>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Disciplina> listaDados) {
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
                'Editar Disciplina',
                style: TextStyle(color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              alignment: const Alignment(1, 0),
              color: Colors.red,
              child: const Text(
                'Excluir Disciplina',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                _abrirTelaCadastro(disciplina: listaDados[index]);
              } else if (direction == DismissDirection.endToStart) {
                _disciplinaHelper.apagar(listaDados[index]);
              }
            },
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await MensagemAlerta.show(
                    context: context,
                    titulo: 'Atenção',
                    texto: 'Deseja excluir essa Disciplina?',
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

  Widget _criarItemLista(Disciplina disciplina) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                disciplina.nome,
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
      onTap: () => _abrirListaNotasFrequencia(disciplina),
      onLongPress: () => _abrirTelaCadastro(disciplina: disciplina),
    );
  }

  void _abrirListaNotasFrequencia(Disciplina disciplina) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => NotasFrequenciasPage(disciplina)
    ));
  }


  void _abrirTelaCadastro({Disciplina? disciplina}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroDisciplina(
                  disciplina: disciplina,
                )));

    setState(() {});
  }
}
