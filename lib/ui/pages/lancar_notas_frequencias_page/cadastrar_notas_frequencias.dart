import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/aluno_helper.dart';
import 'package:trabalho_final_flutter/models/nota_frequencia.dart';
import 'package:trabalho_final_flutter/ui/components/campo_texto.dart';

import '../../../datasources/local/nota_frequencia_helper.dart';
import '../../../models/disciplina.dart';

class CadastrarNotasFrequencias extends StatefulWidget {
  final Disciplina disciplina;
  final NotaFrequencia? notaFrequencia;
  //Aluno? aluno;

  CadastrarNotasFrequencias(this.disciplina, {this.notaFrequencia, Key? key})
      : super(key: key);

  @override
  State<CadastrarNotasFrequencias> createState() =>
      _CadastrarNotasFrequenciasState();
}

class _CadastrarNotasFrequenciasState extends State<CadastrarNotasFrequencias> {
  final _notaFrequenciaHelper = NotaFrequenciaHelper();
  final _notaController = TextEditingController();
  final _frequenciaController = TextEditingController();
  //final _alunoController = TextEditingController();

  var _selectedValue;
  var _aluno = <DropdownMenuItem>[];

@override
  void initState() {
    super.initState();
    _loadAlunos();
     if (widget.notaFrequencia != null) {
      _notaController.text = widget.notaFrequencia!.nota.toString();
      _frequenciaController.text = widget.notaFrequencia!.frequencia.toString();
      _selectedValue = widget.notaFrequencia!.aluno;
    }
  }

  _loadAlunos() async {
    var _selectAluno = AlunoHelper();
    var alunos = await _selectAluno.getTodos();
    alunos.forEach((aluno) {
      setState(() {
        _aluno.add(DropdownMenuItem(
          child: Text(aluno.nome),
          value: aluno.codigo,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Cadastro de Notas e Frequências')),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: DropdownButtonFormField<dynamic>(  
                decoration: const InputDecoration(
                    labelText: 'Aluno',
                    labelStyle: TextStyle(fontSize: 15),
                    prefixText: '',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedValue,
                  items: _aluno,
                  hint: const Text('Aluno'),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
              )
            ),
            CampoTexto(
              controller: _notaController,
              texto: 'Insira a nota do aluno',
              teclado: TextInputType.number,
            ),
            CampoTexto(
              controller: _frequenciaController,
              texto: 'Insira a porcentagem da frequencia do aluno',
              teclado: TextInputType.number,
            ),
            ElevatedButton(onPressed: _salvarNotaFrequencia,
            child: const Text('Salvar')),
            _criarBotaoExcluir(),
          ],
        )

      );
  }


  Widget _criarBotaoExcluir() {
    if (widget.notaFrequencia != null) {
      return ElevatedButton(
          onPressed: _excluirNotaFrequencia,
          child: const Text('Excluir')
      );
    }
    return Container();
  }

  void _excluirNotaFrequencia() {
    _notaFrequenciaHelper.apagar(widget.notaFrequencia!);
    Navigator.pop(context);
  }

  void _salvarNotaFrequencia() {
    if (widget.notaFrequencia != null) {
      widget.notaFrequencia!.nota = int.parse(_notaController.text);
      widget.notaFrequencia!.frequencia = int.parse(_frequenciaController.text);
      widget.notaFrequencia!.aluno = _selectedValue;
      _notaFrequenciaHelper.alterar(widget.notaFrequencia!);
    }
    else {
      _notaFrequenciaHelper.inserir(NotaFrequencia(
          nota: int.parse(_notaController.text),
          frequencia: int.parse(_frequenciaController.text),
          aluno: _selectedValue,
          disciplina: widget.disciplina
      ));
    }
    Navigator.pop(context);
  }



}
