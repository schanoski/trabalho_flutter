import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/professor_helper.dart';
import 'package:trabalho_final_flutter/ui/components/components.dart';

import '../../../models/professor.dart';

class CadastroProfessor extends StatefulWidget {

  final Professor? professor;

  const CadastroProfessor({this.professor, Key? key}) : super(key: key);

  @override
  State<CadastroProfessor> createState() => _CadastroProfessorState();
}

class _CadastroProfessorState extends State<CadastroProfessor> {

  final _professorHelper = ProfessorHelper();
  final _nomeProfessorController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (widget.professor != null) {
      _nomeProfessorController.text = widget.professor!.nome;
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
            Text('Cadastro de Professor', style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
      body: Column(
        children: [
          CampoTexto(
            controller: _nomeProfessorController,
            texto: 'Nome do Professor',
          ),

          ElevatedButton(
              onPressed: _salvarProfessor,
              child: const Text('Salvar')
          ),

          Visibility(
            child: ElevatedButton(
                child: const Text('Excluir'),
                onPressed: _excluirProfessor
            ),
            visible: widget.professor != null,
          ),
        ],
      ),
    );
  }


  void _excluirProfessor() {
    MensagemAlerta.show(
        context: context,
        titulo: 'Atenção',
        texto: 'Deseja excluir essa professor?',
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
    if (widget.professor != null) {
      _professorHelper.apagar(widget.professor!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _salvarProfessor() {
    if (_nomeProfessorController.text.isEmpty) {
      MensagemAlerta.show(
          context: context,
          titulo: 'Atenção',
          texto: 'Nome da professor é obrigatório!',
          botoes: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () { Navigator.pop(context); }
            ),
          ]
      );
      return;
    }
    if (widget.professor != null) {
      widget.professor!.nome = _nomeProfessorController.text;
      _professorHelper.alterar(widget.professor!);
    }
    else {
      _professorHelper.inserir(Professor(nome: _nomeProfessorController.text));
    }
    Navigator.pop(context);
  }
}




