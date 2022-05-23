import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String texto;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final String prefixo;
  final TextInputType teclado;

  const CampoTexto({required this.controller, required this.texto,
    this.left = 16, this.right = 16, this.top = 16, this.bottom = 16,
    this.prefixo = '', this.teclado = TextInputType.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: TextField(
        controller: controller,
        keyboardType: teclado,
        decoration: InputDecoration(
          labelText: texto,
          labelStyle: const TextStyle(fontSize: 15),
          prefixText: prefixo,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}