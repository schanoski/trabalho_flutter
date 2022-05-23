import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trabalho_final_flutter/datasources/local/aluno_helper.dart';
import 'package:trabalho_final_flutter/datasources/local/nota_frequencia_helper.dart';
import 'package:trabalho_final_flutter/datasources/local/professor_helper.dart';
import 'package:trabalho_final_flutter/datasources/local/turma_helper.dart';

import 'disciplina_helper.dart';

class BancoDados {
  static const String _nomeBanco = 'cadastro_alunos.db';

  static final BancoDados _intancia = BancoDados.internal();
  factory BancoDados() => _intancia;
  BancoDados.internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDb = join(path, _nomeBanco);

    return await openDatabase(pathDb, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(sqlCreateTurma);
          await db.execute(sqlCreateDisciplina);
          await db.execute(sqlCreateProfessor);
          await db.execute(sqlCreateAluno);
          await db.execute(sqlCreateNotaFrequencia);
    });
  }

  void close() async {
    Database meuDb = await db;
    meuDb.close();
  }
}
