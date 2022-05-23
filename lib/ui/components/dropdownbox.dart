import 'package:flutter/material.dart';

class MeuDropdown extends StatefulWidget {
  const MeuDropdown({ Key? key }) : super(key: key);

  @override
  State<MeuDropdown> createState() => _MeuDropdownState();
}

class _MeuDropdownState extends State<MeuDropdown> {
  final List<String> _items = ['Primeiro Periodo', 'Segundo Periodo', 'Terceiro Periodo', 'Quarto Periodo'];
  String? _selectedItem = 'Primeiro Periodo';

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding:const EdgeInsets.fromLTRB(16,16,16,16),
                  child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Período',
                        labelStyle: TextStyle(fontSize: 15),
                        prefixText: '',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedItem,
                      items: _items
                          .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: const TextStyle(fontSize: 15),
                          )
                      ))
                          .toList(),
                      onChanged: (item) => setState(() => _selectedItem = item),
                      isExpanded: true
                  ),
              );
  }
}