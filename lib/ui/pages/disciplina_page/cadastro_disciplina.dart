import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/disciplina_helper.dart';
import 'package:trabalho_final_flutter/ui/components/components.dart';

import '../../../models/disciplina.dart';

class CadastroDisciplina extends StatefulWidget {

  final Disciplina? disciplina;

  const CadastroDisciplina({this.disciplina, Key? key}) : super(key: key);

  @override
  State<CadastroDisciplina> createState() => _CadastroDisciplinaState();
}

class _CadastroDisciplinaState extends State<CadastroDisciplina> {

  final _disciplinaHelper = DisciplinaHelper();
  final _nomeDisciplinaController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (widget.disciplina != null) {
      _nomeDisciplinaController.text = widget.disciplina!.nome;
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
            Text('Cadastro de Disciplina', style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
      body: Column(
        children: [
          CampoTexto(
            controller: _nomeDisciplinaController,
            texto: 'Nome do Disciplina',
          ),

          ElevatedButton(
              onPressed: _salvarDisciplina,
              child: const Text('Salvar')
          ),

          Visibility(
            child: ElevatedButton(
                child: const Text('Excluir'),
                onPressed: _excluirDisciplina
            ),
            visible: widget.disciplina != null,
          ),
        ],
      ),
    );
  }


  void _excluirDisciplina() {
    MensagemAlerta.show(
        context: context,
        titulo: 'Atenção',
        texto: 'Deseja excluir essa disciplina?',
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
    if (widget.disciplina != null) {
      _disciplinaHelper.apagar(widget.disciplina!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _salvarDisciplina() {
    if (_nomeDisciplinaController.text.isEmpty) {
      MensagemAlerta.show(
          context: context,
          titulo: 'Atenção',
          texto: 'Nome da disciplina é obrigatório!',
          botoes: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () { Navigator.pop(context); }
            ),
          ]
      );
      return;
    }
    if (widget.disciplina != null) {
      widget.disciplina!.nome = _nomeDisciplinaController.text;
      _disciplinaHelper.alterar(widget.disciplina!);
    }
    else {
      _disciplinaHelper.inserir(Disciplina(nome: _nomeDisciplinaController.text));
    }
    Navigator.pop(context);
  }
}




