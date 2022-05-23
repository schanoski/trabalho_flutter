import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/aluno_helper.dart';

import '../../../datasources/local/nota_frequencia_helper.dart';
import '../../../models/aluno.dart';
import '../../../models/disciplina.dart';
import '../../../models/nota_frequencia.dart';
import 'cadastrar_notas_frequencias.dart';

class NotasFrequenciasPage extends StatefulWidget {
  final Disciplina disciplina;
 // final Aluno? aluno;

  const NotasFrequenciasPage(this.disciplina,  {Key? key}) : super(key: key);

  @override
  State<NotasFrequenciasPage> createState() => _NotasFrequenciasPageState();
}

class _NotasFrequenciasPageState extends State<NotasFrequenciasPage> {
  final _notaFrequenciaHelper = NotaFrequenciaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.disciplina.nome + 'cadastrar notas e frequencias')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _cadastrarNotaFrequencia,
      ),
      body: FutureBuilder(
        future: _notaFrequenciaHelper.getByDisciplinaAluno(widget.disciplina.codigo ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<NotaFrequencia>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<NotaFrequencia> listaDados) {
    return ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: listaDados.length,
        itemBuilder: (context, index) {
          return _criarItemLista(listaDados[index]);
        }
    );
  }

  Widget _criarItemLista(NotaFrequencia notaFrequencia) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              children:[
                Text( notaFrequencia.aluno, style: const TextStyle(fontSize: 28),),
                Text( _resultado(notaFrequencia),
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                )
              ]

          ),


        ),
      ),
      onTap: () => _cadastrarNotaFrequencia(notaFrequencia: notaFrequencia),
    );
  }

  void _cadastrarNotaFrequencia({NotaFrequencia? notaFrequencia}) async {
    await Navigator.push(context, MaterialPageRoute(
        builder: (context) => CadastrarNotasFrequencias(widget.disciplina, notaFrequencia: notaFrequencia,)
    ));

    setState(() { });
  }

  String _resultado(NotaFrequencia notaFrequencia) {
    int nota = notaFrequencia.nota;
    int frequencia = notaFrequencia.frequencia;

    String resultado = "\nNota: $nota \nFrequência: $frequencia%";
    if (nota >= 70 && frequencia >= 30.0) {
      return "Aprovado" + resultado;
    } else if (nota < 70.0) {
      return "Reprovado por nota." + resultado;
    } else if (frequencia < 30.0) {
      return "Reprovado por frequência." + resultado;
    }
    return "";
  }

}