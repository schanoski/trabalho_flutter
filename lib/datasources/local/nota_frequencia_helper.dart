import 'package:sqflite/sqflite.dart';
import 'package:trabalho_final_flutter/datasources/local/banco_dados.dart';
import 'package:trabalho_final_flutter/models/aluno.dart';
import 'package:trabalho_final_flutter/models/disciplina.dart';
import 'package:trabalho_final_flutter/models/nota_frequencia.dart';

import 'aluno_helper.dart';
import 'disciplina_helper.dart';


  const sqlCreateNotaFrequencia = ''' CREATE TABLE $notaFrequenciaTabela (
      $codigo_coluna INTEGER PRIMARY KEY AUTOINCREMENT,
      $nota_coluna INTEGER(3),
      $frequencia_coluna INTEGER(3),
      $disciplina_coluna INTEGER,
      $aluno_coluna INTEGER,
      FOREIGN KEY($disciplina_coluna) REFERENCES $disciplinaTabela($disciplinaCodigo),
      FOREIGN KEY($aluno_coluna) REFERENCES $alunoTabela($alunoCodigo)
    ) ''';


class NotaFrequenciaHelper {

  Future<List<NotaFrequencia>> getTodos() async {
    Database db = await BancoDados().db;
    List dados = await db.rawQuery('SELECT * FROM $notaFrequenciaTabela');
    return dados.map((e) => NotaFrequencia.fromMap(e,e)).toList();
  }

  Future<NotaFrequencia> inserir(NotaFrequencia notaFrequencia) async {
    Database db = await BancoDados().db;
    notaFrequencia.codigo = await db.insert(notaFrequenciaTabela, notaFrequencia.toMap());
    return notaFrequencia;
  }

  Future<int> alterar(NotaFrequencia notaFrequencia) async {
    Database db = await BancoDados().db;

    return db.update(notaFrequenciaTabela,notaFrequencia.toMap(),
      where: '$codigo_coluna = ?',
      whereArgs: [notaFrequencia.codigo]
    );
  }

  Future<int> apagar(NotaFrequencia notaFrequencia) async {
    Database db = await BancoDados().db;

    return await db.delete(notaFrequenciaTabela,
      where: '$codigo_coluna = ?',
      whereArgs: [notaFrequencia.codigo]
    );
  }


  Future<List<NotaFrequencia>> getByDisciplinaAluno(int codDisciplina) async {
    Disciplina? disciplina = await DisciplinaHelper().getDisciplina(codDisciplina);
    //Aluno? aluno = await AlunoHelper().getAluno(codAluno);

    if (disciplina != null) {
      Database db = await BancoDados().db;

      List dados = await db.query(
          notaFrequenciaTabela,
          where: '$disciplina_coluna = ?',
          whereArgs: [codDisciplina],
          orderBy: aluno_coluna
      );

      return dados.map((e) => NotaFrequencia.fromMap(e, disciplina)).toList();
    }

    return [];
  }


  Future<NotaFrequencia?> getNotaFrequencia(int codNotaFrequencia) async {
    Database db = await BancoDados().db;

    List dados = await db.query(
      notaFrequenciaTabela,
      where: '$codigo_coluna = ?',
      whereArgs: [codNotaFrequencia]
    );

    if (dados.isNotEmpty) {
      int codDisciplina = int.parse(dados.first[disciplina_coluna].toString());
      Disciplina disciplina = (await DisciplinaHelper().getDisciplina(codDisciplina))!;

      int codAluno = int.parse(dados.first[aluno_coluna].toString());
      Aluno aluno = (await AlunoHelper().getAluno(codAluno))!;

      return NotaFrequencia.fromMap(dados.first, disciplina);
    }
    return null;
  }
}

