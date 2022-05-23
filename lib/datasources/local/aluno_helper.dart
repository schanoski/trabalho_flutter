import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

import '../../models/aluno.dart';
import 'banco_dados.dart';

const sqlCreateAluno = '''
    CREATE TABLE $alunoTabela (
      $alunoCodigo INTEGER PRIMARY KEY AUTOINCREMENT,
      $alunoNome TEXT,
      $alunoCPF TEXT,
      $alunoRA TEXT
    )
  ''';

class AlunoHelper {
  Future<Aluno> inserir(Aluno aluno) async {
    Database db = await BancoDados().db;

    aluno.codigo = await db.insert(alunoTabela, aluno.toMap());
    return aluno;
  }

  Future<int> alterar(Aluno aluno) async {
    Database db = await BancoDados().db;

    return db.update(alunoTabela, aluno.toMap(),
        where: '$alunoCodigo = ?',
        whereArgs: [aluno.codigo]
    );
  }

  Future<int> apagar(Aluno aluno) async {
    Database db = await BancoDados().db;

    return db.delete(alunoTabela,
        where: '$alunoCodigo = ?',
        whereArgs: [aluno.codigo]
    );
  }

  Future<List<Aluno>> getTodos() async {
    Database db = await BancoDados().db;
    List dados = await db.query(alunoTabela);
    return dados.map((e) => Aluno.fromMap(e)).toList();
  }

  Future<Aluno?> getAluno(int codigo) async {
    Database db = await BancoDados().db;

    List dados = await db.query(alunoTabela,
        columns: [alunoCodigo, alunoNome, alunoCPF, alunoRA],
        where: '$alunoCodigo = ?',
        whereArgs: [codigo]
    );

    if (dados.isNotEmpty) {
      return Aluno.fromMap(dados.first);
    }
    return null;
  }


  Future<int> getTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $alunoTabela')
    ) ?? 0;
  }
}