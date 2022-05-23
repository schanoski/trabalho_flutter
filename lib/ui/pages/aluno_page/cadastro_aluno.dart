import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/datasources/local/aluno_helper.dart';
import 'package:trabalho_final_flutter/ui/components/components.dart';

import '../../../models/aluno.dart';

class CadastroAluno extends StatefulWidget {
  final Aluno? aluno;

  const CadastroAluno({this.aluno, Key? key}) : super(key: key);

  @override
  State<CadastroAluno> createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {
  final _alunoHelper = AlunoHelper();
  final _nomeAlunoController = TextEditingController();
  final _cpfAlunoController = TextEditingController();
  final _raAlunoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.aluno != null) {
      _nomeAlunoController.text = widget.aluno!.nome;
      _cpfAlunoController.text = widget.aluno!.cpf;
      _raAlunoController.text = widget.aluno!.ra;
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
            Text(
              'Cadastro de Aluno',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          CampoTexto(
            controller: _nomeAlunoController,
            texto: 'Nome do Aluno',
          ),
          CampoTextoCpf(
            controller: _cpfAlunoController,
            texto: 'CPF do Aluno',
          ),
          CampoTexto(
            controller: _raAlunoController,
            texto: 'Registro Acadêmico do Aluno',
            teclado: TextInputType.number,
          ),
          ElevatedButton(onPressed: _salvarAluno, child: const Text('Salvar')),
          Visibility(
            child: ElevatedButton(
                child: const Text('Excluir'), onPressed: _excluirAluno),
            visible: widget.aluno != null,
          ),
        ],
      ),
    );
  }

  void _excluirAluno() {
    MensagemAlerta.show(
        context: context,
        titulo: 'Atenção',
        texto: 'Deseja excluir esse aluno?',
        botoes: [
          TextButton(child: const Text('Sim'), onPressed: _confirmarExclusao),
          ElevatedButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ]);
  }

  void _confirmarExclusao() {
    if (widget.aluno != null) {
      _alunoHelper.apagar(widget.aluno!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _salvarAluno() {
    if (_nomeAlunoController.text.isEmpty ||
        _cpfAlunoController.text.isEmpty ||
        _raAlunoController.text.isEmpty) {
      MensagemAlerta.show(
          context: context,
          titulo: 'Atenção',
          texto: 'Nome dos campos são obrigatório!',
          botoes: [
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ]);
      return;
    }
    if (widget.aluno != null) {
      widget.aluno!.nome = _nomeAlunoController.text;
      widget.aluno!.cpf = _cpfAlunoController.text;
      widget.aluno!.cpf = _raAlunoController.text;
      _alunoHelper.alterar(widget.aluno!);
    } else {
      _alunoHelper.inserir(Aluno(
          nome: _nomeAlunoController.text,
          cpf: _cpfAlunoController.text,
          ra: _raAlunoController.text));
    }
    Navigator.pop(context);
  }
}
