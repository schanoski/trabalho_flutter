import 'package:flutter/material.dart';

import '../../../models/disciplina.dart';
import 'cadastrar_notas_frequencias.dart';

class RelatorioAlunosPage extends StatefulWidget {
  final Disciplina disciplina;

  const RelatorioAlunosPage(this.disciplina,{Key? key}) : super(key: key);

  @override
  State<RelatorioAlunosPage> createState() => _RelatorioAlunosPageState();
}

class _RelatorioAlunosPageState
    extends State<RelatorioAlunosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatório')),
    );
  }

}