const disciplinaTabela = 'TbDisciplina';
const disciplinaCodigo = 'codigo';
const disciplinaNome = 'nome';

class Disciplina {
  int? codigo;
  String nome;

  Disciplina({this.codigo, required this.nome});

  factory Disciplina.fromMap(Map map) {
    return Disciplina(
        codigo: int.tryParse(map[disciplinaCodigo].toString()),
        nome: map[disciplinaNome]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      disciplinaCodigo: codigo,
      disciplinaNome: nome
    };
  }
}