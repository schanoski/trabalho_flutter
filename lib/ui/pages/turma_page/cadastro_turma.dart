import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/turma_helper.dart';
import 'package:trabalho_final_flutter/ui/components/components.dart';

import '../../../models/turma.dart';

class CadastroTurma extends StatefulWidget {

  final Turma? turma;

  const CadastroTurma({this.turma, Key? key}) : super(key: key);

  @override
  State<CadastroTurma> createState() => _CadastroTurmaState();
}

class _CadastroTurmaState extends State<CadastroTurma> {

  final _turmaHelper = TurmaHelper();
  final _nomeTurmaController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (widget.turma != null) {
      _nomeTurmaController.text = widget.turma!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.home, size: 30),
            Text('Cadastro de Turma', style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
      body: Column(
        children: [
          CampoTexto(
            controller: _nomeTurmaController,
            texto: 'Nome do Turma',
          ),

          ElevatedButton(
              onPressed: _salvarTurma,
              child: const Text('Salvar')
          ),

          Visibility(
            child: ElevatedButton(
                child: const Text('Excluir'),
                onPressed: _excluirTurma
            ),
            visible: widget.turma != null,
          ),
        ],
      ),
    );
  }


  void _excluirTurma() {
    MensagemAlerta.show(
        context: context,
        titulo: 'Atenção',
        texto: 'Deseja excluir essa turma?',
        botoes: [
          TextButton(
              child: const Text('Sim'),
              onPressed: _confirmarExclusao
          ),
          ElevatedButton(
              child: const Text('Não'),
              onPressed: (){ Navigator.pop(context); }
          ),
        ]
    );
  }

  void _confirmarExclusao() {
    if (widget.turma != null) {
      _turmaHelper.apagar(widget.turma!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _salvarTurma() {
    if (_nomeTurmaController.text.isEmpty) {
      MensagemAlerta.show(
          context: context,
          titulo: 'Atenção',
          texto: 'Nome da turma é obrigatório!',
          botoes: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () { Navigator.pop(context); }
            ),
          ]
      );
      return;
    }
    if (widget.turma != null) {
      widget.turma!.nome = _nomeTurmaController.text;
      _turmaHelper.alterar(widget.turma!);
    }
    else {
      _turmaHelper.inserir(Turma(nome: _nomeTurmaController.text));
    }
    Navigator.pop(context);
  }
}




