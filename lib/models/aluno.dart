
/*
  $alunoCodigo INTEGER PRIMARY KEY AUTOINCREMENT,
  $alunoNome TEXT,
  $alunoCPF TEXT,
  $alunoRA TEXT
*/

const alunoTabela = 'TbAluno';
const alunoCodigo = 'codigo';
const alunoNome = 'nome';
const alunoCPF = 'cpf';
const alunoRA = 'ra';

class Aluno {
  int? codigo;
  String nome;
  String cpf;
  String ra;

  Aluno({this.codigo, required this.nome, required this.cpf, required this.ra});

  factory Aluno.fromMap(Map map) {
    return Aluno(
        codigo: int.tryParse(map[alunoCodigo].toString()),
        nome: map[alunoNome],
        cpf: map[alunoCPF],
        ra: map[alunoRA]
      );
  }

  Map<String, dynamic> toMap() {
    return {alunoCodigo: codigo, alunoNome: nome, alunoCPF: cpf, alunoRA: ra};
  }
}
