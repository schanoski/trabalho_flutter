import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

import '../../models/disciplina.dart';
import 'banco_dados.dart';

const sqlCreateDisciplina = '''
    CREATE TABLE $disciplinaTabela (
      $disciplinaCodigo INTEGER PRIMARY KEY AUTOINCREMENT,
      $disciplinaNome TEXT
    )
  ''';

class DisciplinaHelper {
  Future<Disciplina> inserir(Disciplina disciplina) async {
    Database db = await BancoDados().db;

    disciplina.codigo = await db.insert(disciplinaTabela, disciplina.toMap());
    return disciplina;
  }

  Future<int> alterar(Disciplina disciplina) async {
    Database db = await BancoDados().db;

    return db.update(disciplinaTabela, disciplina.toMap(),
        where: '$disciplinaCodigo = ?',
        whereArgs: [disciplina.codigo]
    );
  }

  Future<int> apagar(Disciplina disciplina) async {
    Database db = await BancoDados().db;

    return db.delete(disciplinaTabela,
        where: '$disciplinaCodigo = ?',
        whereArgs: [disciplina.codigo]
    );
  }

  Future<List<Disciplina>> getTodos() async {
    Database db = await BancoDados().db;
    List dados = await db.query(disciplinaTabela);
    return dados.map((e) => Disciplina.fromMap(e)).toList();
  }

  Future<Disciplina?> getDisciplina(int codigo) async {
    Database db = await BancoDados().db;

    List dados = await db.query(disciplinaTabela,
        columns: [disciplinaCodigo, disciplinaNome],
        where: '$disciplinaCodigo = ?',
        whereArgs: [codigo]
    );

    if (dados.isNotEmpty) {
      return Disciplina.fromMap(dados.first);
    }
    return null;
  }

  Future<int> getTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $disciplinaTabela')
    ) ?? 0;
  }
}