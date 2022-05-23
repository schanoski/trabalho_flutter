const professorTabela = 'TbProfessor';
const professorCodigo = 'codigo';
const professorNome = 'nome';

class Professor {
  int? codigo;
  String nome;

  Professor({this.codigo, required this.nome});

  factory Professor.fromMap(Map map) {
    return Professor(
        codigo: int.tryParse(map[professorCodigo].toString()),
        nome: map[professorNome]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      professorCodigo: codigo,
      professorNome: nome
    };
  }
}