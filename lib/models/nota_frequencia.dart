import 'dart:ffi';

import 'disciplina.dart';
import 'aluno.dart';

const notaFrequenciaTabela = 'TbNotaFrequencia';
const codigo_coluna = 'codigo';
const nota_coluna = 'nota';
const frequencia_coluna = 'frequencia';
const aluno_coluna = 'cod_aluno';
const disciplina_coluna = 'cod_disciplina';


class NotaFrequencia {

  int? codigo;
  int nota;
  int frequencia;
  int aluno;
  Disciplina disciplina;

  NotaFrequencia({
    this.codigo,
    required this.nota,
    required this.frequencia,
    required this.aluno,
    required this.disciplina
  });

  factory NotaFrequencia.fromMap(Map map, Disciplina disciplina) {
    return NotaFrequencia(
        codigo: int.tryParse(map[codigo_coluna].toString()),
        nota: int.parse(map[nota_coluna].toString()),
        frequencia: int.parse(map[frequencia_coluna].toString()),
        aluno: int.parse(map[aluno_coluna].toString()),
        disciplina: disciplina
        );
  }

  Map<String, dynamic> toMap() {
    return {
      codigo_coluna: codigo,
      nota_coluna: nota,
      frequencia_coluna: frequencia,
      aluno_coluna: aluno,
      disciplina_coluna: disciplina.codigo
    };
  }
}
