import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

import '../../models/professor.dart';
import 'banco_dados.dart';

const sqlCreateProfessor = '''
    CREATE TABLE $professorTabela (
      $professorCodigo INTEGER PRIMARY KEY AUTOINCREMENT,
      $professorNome TEXT
    )
  ''';

class ProfessorHelper {
  Future<Professor> inserir(Professor professor) async {
    Database db = await BancoDados().db;

    professor.codigo = await db.insert(professorTabela, professor.toMap());
    return professor;
  }

  Future<int> alterar(Professor professor) async {
    Database db = await BancoDados().db;

    return db.update(professorTabela, professor.toMap(),
        where: '$professorCodigo = ?',
        whereArgs: [professor.codigo]
    );
  }

  Future<int> apagar(Professor professor) async {
    Database db = await BancoDados().db;

    return db.delete(professorTabela,
        where: '$professorCodigo = ?',
        whereArgs: [professor.codigo]
    );
  }

  Future<List<Professor>> getTodos() async {
    Database db = await BancoDados().db;

    //List dados = await db.rawQuery('SELECT * FROM $professorTabela');
    List dados = await db.query(professorTabela);

    return dados.map((e) => Professor.fromMap(e)).toList();
  }

  Future<Professor?> getProfessor(int codigo) async {
    Database db = await BancoDados().db;

    List dados = await db.query(professorTabela,
        columns: [professorCodigo, professorNome],
        where: '$professorCodigo = ?',
        whereArgs: [codigo]
    );

    if (dados.isNotEmpty) {
      return Professor.fromMap(dados.first);
    }
    return null;
  }

  Future<int> getTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $professorTabela')
    ) ?? 0;
  }
}