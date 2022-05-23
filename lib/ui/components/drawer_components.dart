import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/ui/pages/pages.dart';
import '../pages/disciplina_page/lista_disciplina_page.dart';
import '../pages/professor_page/lista_professor_page.dart';

class DrawerComponents extends StatelessWidget {
  const DrawerComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _home() {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const HomePage()
      ));
    }

    void _turmas() {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const ListaTurmaPage()
      ));
    }
/*
    void _notasFrequencias() {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const ListaNotasFrequenciasPage()
      ));
    }
*/


    void _disciplina(){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const ListaDisciplinaPage()
      ));
    }

    void _aluno(){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const ListaAlunoPage()
      ));
    }

    void _professor(){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const ListaProfessorPage()
        ));
    }

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Universidade'),
            decoration: BoxDecoration(
                color: Colors.blue
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Home'),
            onTap: _home,
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Turmas'),
            onTap: _turmas,
          ),
          ListTile(
            leading: const Icon(Icons.school),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Professor'),
            onTap: _professor,
          ),
          ListTile(
            leading: const  Icon(Icons.book),
            trailing: const  Icon(Icons.arrow_forward_ios),
            title: const  Text('Disciplina'),
            onTap: _disciplina,
          ),
          ListTile(
            leading: const Icon(Icons.people),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Alunos'),
            onTap: _aluno,
          ),

/*
          ListTile(
            leading: const Icon(Icons.numbers),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: const Text('Notas e Frequências'),
            onTap: _notasFrequencias,
          )
          */


        ],
      )
    );
  }
}
